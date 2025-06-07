package com.dotuandat.services.impl;

import com.dotuandat.dtos.request.inventoryReceipt.InventoryReceiptRequest;
import com.dotuandat.services.InventoryImportService;
import com.dotuandat.services.InventoryReceiptService;
import com.dotuandat.utils.ExcelInventoryHelper;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class InventoryImportServiceImpl implements InventoryImportService {
    ExcelInventoryHelper excelInventoryHelper;
    InventoryReceiptService inventoryReceiptService;

    @Override
    public void importFromExcel(MultipartFile file) {
        InventoryReceiptRequest request = excelInventoryHelper.parseExcel(file);
        inventoryReceiptService.create(request);
    }
}
