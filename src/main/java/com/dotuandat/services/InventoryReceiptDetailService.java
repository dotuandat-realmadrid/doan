package com.dotuandat.services;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.inventoryReceipt.ReceiptDetailByProductResponse;

public interface InventoryReceiptDetailService {
    PageResponse<ReceiptDetailByProductResponse> getAllByProductId(String productId, Pageable pageable);
}
