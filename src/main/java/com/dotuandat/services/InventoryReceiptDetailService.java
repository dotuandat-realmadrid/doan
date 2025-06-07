package com.dotuandat.services;

import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.inventoryReceipt.ReceiptDetailByProductResponse;
import org.springframework.data.domain.Pageable;

public interface InventoryReceiptDetailService {
    PageResponse<ReceiptDetailByProductResponse> getAllByProductId(String productId, Pageable pageable);
}
