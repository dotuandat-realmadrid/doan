package com.dotuandat.services;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.request.inventoryReceipt.InventoryReceiptRequest;
import com.dotuandat.dtos.request.inventoryReceipt.InventorySearchRequest;
import com.dotuandat.dtos.request.inventoryReceipt.InventoryStatusRequest;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.inventoryReceipt.InventoryReceiptResponse;
import com.dotuandat.enums.InventoryStatus;

public interface InventoryReceiptService {
    PageResponse<InventoryReceiptResponse> search(InventorySearchRequest request, Pageable pageable);

    PageResponse<InventoryReceiptResponse> getAllByStatus(InventoryStatus status, Pageable pageable);

    InventoryReceiptResponse getById(String id);

    InventoryReceiptResponse create(InventoryReceiptRequest request);

    InventoryReceiptResponse update(String id, InventoryReceiptRequest request);

    InventoryReceiptResponse updateStatus(String id, InventoryStatusRequest request);

    int countTotalPendingReceipts();

    List<InventoryReceiptResponse> getExpiringProducts(String filter);
}
