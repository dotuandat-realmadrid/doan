package com.dotuandat.utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import com.dotuandat.dtos.request.inventoryReceipt.InventoryReceiptDetailRequest;
import com.dotuandat.dtos.request.inventoryReceipt.InventoryReceiptRequest;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class PdfInventoryHelper {
    public InventoryReceiptRequest parsePdf(MultipartFile file) {
        InventoryReceiptRequest request = new InventoryReceiptRequest();
        List<InventoryReceiptDetailRequest> detailRequests = new ArrayList<>();
        long totalAmount = 0L;

        try (PDDocument document = PDDocument.load(file.getInputStream())) {
            PDFTextStripper stripper = new PDFTextStripper();
            String text = stripper.getText(document);
//            log.info("Nội dung text từ PDF: {}", text); // Debug
            String[] lines = text.split("\\r?\\n");

            if (text.trim().isEmpty() || !lines[0].trim().contains("productCode")) {
                throw new AppException(ErrorCode.INVALID_FILE_PDF_FORMAT);
            }

            // Lấy note từ dòng cuối nếu có
            String globalNote = null;
            if (lines.length > 1) {
                String lastLine = lines[lines.length - 1].trim();
                if (!lastLine.isEmpty() && lastLine.length() <= 255) {
                    globalNote = lastLine;
                }
            }

            // Bỏ qua dòng header và dòng note (nếu có)
            for (int i = 1; i < (globalNote != null ? lines.length - 1 : lines.length); i++) {
                String line = lines[i].trim();
                if (line.isEmpty()) continue;

                InventoryReceiptDetailRequest detailRequest = parseLine(line, i, globalNote);
                if (detailRequest != null) {
                    detailRequests.add(detailRequest);
                    totalAmount += detailRequest.getQuantity() * detailRequest.getPrice();
                }
            }

            request.setDetails(detailRequests);
            request.setTotalAmount(totalAmount);
            if (globalNote != null) {
                request.setNote(globalNote); // Gán note chung cho request
            }
        } catch (IOException e) {
            throw new AppException(ErrorCode.FILE_READ_PDF_ERROR);
        }

        if (detailRequests.isEmpty()) {
            throw new AppException(ErrorCode.PRODUCT_NOT_EXISTED);
        }

        return request;
    }

    private InventoryReceiptDetailRequest parseLine(String line, int lineNumber, String globalNote) {
        try {
            String[] columns = line.trim().split("\\s+", -1); // Tách tất cả cột
            if (columns.length < 3) {
                log.warn("Dòng {} không đủ cột dữ liệu: {}", lineNumber, line);
                return null;
            }

            String productCode = columns[0];
            if (productCode == null || productCode.isEmpty()) {
                throw new AppException(ErrorCode.PRODUCT_NOT_EXISTED);
            }

            int quantity;
            try {
                quantity = Integer.parseInt(columns[1].replace(",", ""));
                if (quantity <= 0) {
                    throw new AppException(ErrorCode.MIN_QUANTITY);
                }
            } catch (NumberFormatException e) {
                log.warn("Dòng {}: Số lượng không hợp lệ - {}", lineNumber, columns[1]);
                return null;
            }

            long price;
            try {
                price = Long.parseLong(columns[2].replace(",", ""));
                if (price <= 1000) {
                    throw new AppException(ErrorCode.MIN_PRICE);
                }
            } catch (NumberFormatException e) {
                log.warn("Dòng {}: Giá không hợp lệ - {}", lineNumber, columns[2]);
                return null;
            }

            String note = columns.length > 3 ? columns[3] : globalNote; // Sử dụng note từ cột hoặc note chung
            if (note != null && note.length() > 255) {
                throw new AppException(ErrorCode.MIN_QUANTITY);
            }

            return InventoryReceiptDetailRequest.builder()
                    .productCode(productCode)
                    .quantity(quantity)
                    .price(price)
                    .build();
        } catch (Exception e) {
            log.warn("Bỏ qua dòng {} do lỗi: {}", lineNumber, e.getMessage());
            return null;
        }
    }

    private String parseNote(String line) {
        String[] columns = line.split("\\s+", -1);
        return columns.length > 3 ? columns[3] : null;
    }
}