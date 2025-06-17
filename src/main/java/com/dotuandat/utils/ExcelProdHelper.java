package com.dotuandat.utils;

import com.dotuandat.dtos.request.product.ProductCreateRequest;
import com.dotuandat.dtos.request.product.ProductUpdateRequest;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Component
@Slf4j
public class ExcelProdHelper {
    private static final String SHEET_NAME = "products";

    public List<ProductCreateRequest> parseCreateExcel(MultipartFile file) {
        List<ProductCreateRequest> products = new ArrayList<>();

        try (Workbook workbook = new XSSFWorkbook(file.getInputStream())) {
            Sheet sheet = workbook.getSheet(SHEET_NAME);
            if (sheet == null) {
                throw new AppException(ErrorCode.INVALID_FILE_FORMAT);
            }

            for (Row row : sheet) {
                if (row.getRowNum() == 0) continue; // Bỏ qua header

                ProductCreateRequest request = parseCreateRow(row);
                if (request != null) {
                    products.add(request);
                }
            }
        } catch (IOException e) {
            throw new AppException(ErrorCode.FILE_READ_ERROR);
        }

        return products;
    }

    private ProductCreateRequest parseCreateRow(Row row) {
        try {
            String categoryCode = getStringCellValue(row, 0);
            String code = getStringCellValue(row, 2);
            String name = getStringCellValue(row, 3);

            // Bỏ qua dòng nếu các trường bắt buộc là null hoặc rỗng
            if (isEmpty(categoryCode) || isEmpty(code) || isEmpty(name)) {
                log.warn("Bỏ qua dòng {} do thiếu các trường bắt buộc", row.getRowNum());
                return null;
            }

            return ProductCreateRequest.builder()
                    .categoryCode(categoryCode)
                    .supplierCode(getStringCellValue(row, 1))
                    .code(code)
                    .name(name)
                    .description(getStringCellValue(row, 4))
                    .price((long) getNumericCellValue(row, 5))
                    .build();
        } catch (Exception e) {
            log.warn("Bỏ qua dòng {} do lỗi: {}", row.getRowNum(), e.getMessage());
            return null;
        }
    }
    
    public List<Pair<String, ProductUpdateRequest>> parseUpdateExcel(MultipartFile file) {
        List<Pair<String, ProductUpdateRequest>> products = new ArrayList<>();

        try (Workbook workbook = new XSSFWorkbook(file.getInputStream())) {
            Sheet sheet = workbook.getSheet(SHEET_NAME);
            if (sheet == null) {
                throw new AppException(ErrorCode.INVALID_FILE_FORMAT);
            }

            for (Row row : sheet) {
                if (row.getRowNum() == 0) continue; // Bỏ qua header

                Pair<String, ProductUpdateRequest> pair = parseUpdateRow(row);
                if (pair != null) {
                    products.add(pair);
                }
            }
        } catch (IOException e) {
            throw new AppException(ErrorCode.FILE_READ_ERROR);
        }

        return products;
    }

    private Pair<String, ProductUpdateRequest> parseUpdateRow(Row row) {
        try {
            String categoryCode = getStringCellValue(row, 0);
            String supplierCode = getStringCellValue(row, 1);
            String code = getStringCellValue(row, 2);
            String name = getStringCellValue(row, 3);

            if (isEmpty(categoryCode) || isEmpty(supplierCode) || isEmpty(code) || isEmpty(name)) {
                log.warn("Bỏ qua dòng {} do thiếu các trường bắt buộc", row.getRowNum());
                return null;
            }

            String discountId = getStringCellValue(row, 6);
            if (isEmpty(discountId)) {
                discountId = null;
            }

            ProductUpdateRequest request = ProductUpdateRequest.builder()
                    .categoryCode(categoryCode)
                    .supplierCode(supplierCode)
                    .name(name)
                    .description(getStringCellValue(row, 4))
                    .price((long) getNumericCellValue(row, 5))
                    .discountId(discountId)
                    .build();

            return Pair.of(code, request);
        } catch (Exception e) {
            log.warn("Bỏ qua dòng {} do lỗi: {}", row.getRowNum(), e.getMessage());
            return null;
        }
    }

    private String getStringCellValue(Row row, int index) {
        Cell cell = row.getCell(index, Row.MissingCellPolicy.RETURN_BLANK_AS_NULL);
        return (cell == null) ? null : cell.getStringCellValue().trim();
    }

    private double getNumericCellValue(Row row, int index) {
        Cell cell = row.getCell(index, Row.MissingCellPolicy.RETURN_BLANK_AS_NULL);
        return (cell == null) ? 0 : cell.getNumericCellValue();
    }
    
    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}
