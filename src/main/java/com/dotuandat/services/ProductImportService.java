package com.dotuandat.services;

import org.springframework.web.multipart.MultipartFile;

public interface ProductImportService {
    void importCreateFromExcel(MultipartFile file);
    void importUpdateFromExcel(MultipartFile file);
}
