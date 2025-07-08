package com.dotuandat.services;

import org.springframework.web.multipart.MultipartFile;

public interface InventoryImportService {
    void importFromExcel(MultipartFile file);
	void importFromQR(MultipartFile file, String qrContent, String source);
	void importFromAI(int quantity);
	void importFromPdf(MultipartFile file);
}
