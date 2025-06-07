package com.dotuandat.converters;

import com.dotuandat.constants.StatusConstant;
import com.dotuandat.dtos.request.inventoryReceipt.InventoryReceiptDetailRequest;
import com.dotuandat.dtos.response.inventoryReceipt.InventoryReceiptDetailResponse;
import com.dotuandat.dtos.response.inventoryReceipt.InventoryReceiptResponse;
import com.dotuandat.dtos.response.inventoryReceipt.ReceiptDetailByProductResponse;
import com.dotuandat.entities.InventoryReceipt;
import com.dotuandat.entities.InventoryReceiptDetail;
import com.dotuandat.entities.Product;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.ProductRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class InventoryReceiptConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private ProductRepository productRepository;

    public InventoryReceiptResponse toResponse(InventoryReceipt receipt,
                                               List<InventoryReceiptDetail> details) {
        List<InventoryReceiptDetailResponse> detailResponses = details.stream()
                .map(detail -> InventoryReceiptDetailResponse.builder()
                        .id(detail.getId())
                        .productId(detail.getProduct().getId())
                        .productCode(detail.getProduct().getCode())
                        .quantity(detail.getQuantity())
                        .price(detail.getPrice())
                        .build())
                .collect(Collectors.toList());

        InventoryReceiptResponse receiptResponse = modelMapper.map(receipt, InventoryReceiptResponse.class);
        receiptResponse.setDetailResponses(detailResponses);
        return receiptResponse;
    }

    public List<ReceiptDetailByProductResponse> toDetailResponse(Page<InventoryReceiptDetail> receiptDetails) {
        return receiptDetails.stream()
                .map(receiptDetail -> {
                    var detailResponse = modelMapper.map(receiptDetail, ReceiptDetailByProductResponse.class);

                    detailResponse.setReceiptId(receiptDetail.getReceipt().getId());
                    detailResponse.setProductId(receiptDetail.getProduct().getId());
                    detailResponse.setProductCode(receiptDetail.getProduct().getCode());
                    detailResponse.setStatus(receiptDetail.getReceipt().getStatus());

                    return detailResponse;
                })
                .toList();
    }

    public List<InventoryReceiptDetail> toDetailEntity(InventoryReceipt receipt,
                                                       List<InventoryReceiptDetailRequest> details) {
        return details.stream()
                .map(detailRequest -> {
                    Product product = productRepository
                            .findByCodeAndIsActive(detailRequest.getProductCode(), StatusConstant.ACTIVE)
                            .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED));

                    return InventoryReceiptDetail.builder()
                            .receipt(receipt)
                            .product(product)
                            .quantity(detailRequest.getQuantity())
                            .price(detailRequest.getPrice())
                            .build();
                })
                .collect(Collectors.toList());
    }
}
