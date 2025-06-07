package com.dotuandat.services.impl;

import com.dotuandat.converters.InventoryReceiptConverter;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.inventoryReceipt.ReceiptDetailByProductResponse;
import com.dotuandat.entities.InventoryReceiptDetail;
import com.dotuandat.repositories.InventoryReceiptDetailRepository;
import com.dotuandat.services.InventoryReceiptDetailService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class InventoryReceiptDetailServiceImpl implements InventoryReceiptDetailService {
    InventoryReceiptDetailRepository receiptDetailRepository;
    InventoryReceiptConverter converter;

    @Override
    @PreAuthorize("hasAuthority('CRU_RECEIPT')")
    public PageResponse<ReceiptDetailByProductResponse> getAllByProductId(String productId, Pageable pageable) {
        Page<InventoryReceiptDetail> receiptDetails = receiptDetailRepository.findByProductId(productId, pageable);

        return PageResponse.<ReceiptDetailByProductResponse>builder()
                .totalPage(receiptDetails.getTotalPages())
                .currentPage(pageable.getPageNumber() + 1)
                .pageSize(pageable.getPageSize())
                .totalElements(receiptDetails.getTotalElements())
                .data(converter.toDetailResponse(receiptDetails))
                .build();
    }
}
