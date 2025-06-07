package com.dotuandat.services;

import org.springframework.web.multipart.MultipartFile;

public interface InventoryImportService {
    void importFromExcel(MultipartFile file);
}
