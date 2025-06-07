package com.dotuandat.services.impl;

import com.dotuandat.converters.InventoryReceiptConverter;
import com.dotuandat.dtos.request.inventoryReceipt.InventoryReceiptRequest;
import com.dotuandat.dtos.request.inventoryReceipt.InventorySearchRequest;
import com.dotuandat.dtos.request.inventoryReceipt.InventoryStatusRequest;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.inventoryReceipt.InventoryReceiptResponse;
import com.dotuandat.entities.InventoryReceipt;
import com.dotuandat.entities.InventoryReceiptDetail;
import com.dotuandat.entities.Product;
import com.dotuandat.enums.InventoryStatus;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.InventoryReceiptRepository;
import com.dotuandat.repositories.ProductRepository;
import com.dotuandat.services.InventoryReceiptService;
import com.dotuandat.specifications.InventorySpecification;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class InventoryReceiptServiceImpl implements InventoryReceiptService {
    InventoryReceiptRepository receiptRepository;
    ProductRepository productRepository;
    ModelMapper modelMapper;
    InventoryReceiptConverter converter;

    @Override
    @PreAuthorize("hasAuthority('CRU_RECEIPT')")
    public PageResponse<InventoryReceiptResponse> search(InventorySearchRequest request, Pageable pageable) {
        Specification<InventoryReceipt> specification = Specification
                .where(InventorySpecification.withId(request.getId()))
                .and(InventorySpecification.withEmail(request.getEmail()))
                .and(InventorySpecification.withDateRange(request.getStartDate(), request.getEndDate()));

        Page<InventoryReceipt> receipts = receiptRepository.findAll(specification, pageable);

        List<InventoryReceiptResponse> receiptResponses = receipts.stream()
                .map((receipt) -> modelMapper.map(receipt, InventoryReceiptResponse.class))
                .toList();

        return PageResponse.<InventoryReceiptResponse>builder()
                .totalPage(receipts.getTotalPages())
                .pageSize(pageable.getPageSize())
                .currentPage(pageable.getPageNumber() + 1)
                .totalElements(receipts.getTotalElements())
                .data(receiptResponses)
                .build();
    }

    @Override
    @PreAuthorize("hasAuthority('CRU_RECEIPT')")
    public PageResponse<InventoryReceiptResponse> getAllByStatus(InventoryStatus status, Pageable pageable) {
        Page<InventoryReceipt> receipts = receiptRepository.findAllByStatus(status, pageable);

        List<InventoryReceiptResponse> receiptResponses = receipts.stream()
                .map((receipt) -> modelMapper.map(receipt, InventoryReceiptResponse.class))
                .toList();

        return PageResponse.<InventoryReceiptResponse>builder()
                .totalPage(receipts.getTotalPages())
                .pageSize(pageable.getPageSize())
                .currentPage(pageable.getPageNumber() + 1)
                .totalElements(receipts.getTotalElements())
                .data(receiptResponses)
                .build();
    }

    @Override
    @PreAuthorize("hasAuthority('CRU_RECEIPT')")
    public InventoryReceiptResponse getById(String id) {
        InventoryReceipt receipt = receiptRepository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.INVENTORY_RECEIPT_NOT_EXISTED));

        return converter.toResponse(receipt, receipt.getDetails());
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CRU_RECEIPT')")
    public InventoryReceiptResponse create(InventoryReceiptRequest request) {
        // save receipt
        InventoryReceipt receipt = InventoryReceipt.builder()
                .totalAmount(request.getTotalAmount())
                .status(InventoryStatus.PENDING)
                .note(request.getNote())
                .build();

        // receipt detail
        List<InventoryReceiptDetail> details = converter.toDetailEntity(receipt, request.getDetails());
        receipt.setDetails(details);

        receiptRepository.save(receipt);

        return converter.toResponse(receipt, details);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CRU_RECEIPT')")
    public InventoryReceiptResponse update(String id, InventoryReceiptRequest request) {
        InventoryReceipt receipt = receiptRepository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.INVENTORY_RECEIPT_NOT_EXISTED));

        // Chỉ update khi ở trạng thái pending
        if (!InventoryStatus.PENDING.equals(receipt.getStatus()))
            throw new AppException(ErrorCode.CAN_NOT_EDITABLE);

        // save updated receipt
        receipt.setTotalAmount(request.getTotalAmount());
        receipt.setNote(request.getNote());

        // Xóa liên kết cũ
        receipt.getDetails().clear();

        // Thêm danh sách mới
        receipt.getDetails().addAll(converter.toDetailEntity(receipt, request.getDetails()));

        receiptRepository.save(receipt);

        return converter.toResponse(receipt, receipt.getDetails());
    }

    @Override
    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public InventoryReceiptResponse updateStatus(String id, InventoryStatusRequest request) {
        InventoryReceipt receipt = receiptRepository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.INVENTORY_RECEIPT_NOT_EXISTED));

        // Chỉ update khi ở trạng thái pending
        if (!InventoryStatus.PENDING.equals(receipt.getStatus()))
            throw new AppException(ErrorCode.CAN_NOT_EDITABLE);

        // New status: COMPLETED, update số lượng sản phẩm
        if (InventoryStatus.COMPLETED.equals(request.getStatus())) {
            updateProductInventory(receipt);
        }

        receipt.setStatus(request.getStatus());
        receiptRepository.save(receipt);

        return converter.toResponse(receipt, receipt.getDetails());
    }

    @Override
    public int countTotalPendingReceipts() {
        return receiptRepository.countByStatus(InventoryStatus.PENDING);
    }

    private void updateProductInventory(InventoryReceipt receipt) {
        List<Product> updatedProducts = receipt.getDetails().stream()
                .map(detail -> {
                    Product product = detail.getProduct();
                    // update inventory quantity
                    product.setInventoryQuantity(product.getInventoryQuantity() + detail.getQuantity());
                    return product;
                })
                .toList();

        productRepository.saveAll(updatedProducts);
    }
}
