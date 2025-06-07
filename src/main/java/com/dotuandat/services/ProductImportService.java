package com.dotuandat.services;

import org.springframework.web.multipart.MultipartFile;

public interface ProductImportService {
    void importFromExcel(MultipartFile file);
}
