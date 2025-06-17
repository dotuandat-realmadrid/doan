package com.dotuandat.services.impl;

import com.dotuandat.dtos.request.product.ProductCreateRequest;
import com.dotuandat.dtos.request.product.ProductUpdateRequest;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.services.ProductImportService;
import com.dotuandat.services.ProductService;
import com.dotuandat.utils.ExcelProdHelper;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

import org.springframework.data.util.Pair;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ProductImportServiceImpl implements ProductImportService {
    ProductService productService;
    ExcelProdHelper excelProdHelper;

    @Override
    @Async
    public void importCreateFromExcel(MultipartFile file) {
        List<ProductCreateRequest> requests = excelProdHelper.parseCreateExcel(file);

        for (ProductCreateRequest request : requests) {
            asyncCreate(request);
        }
    }

    @Async
    public void asyncCreate(ProductCreateRequest request) {
        try {
            productService.create(request);
            log.info("Thêm sản phẩm {} thành công!", request.getCode());
        } catch (AppException e) {
            log.error("Lỗi khi thêm sản phẩm {}: {}", request.getCode(), e.getErrorCode().getMessage());
        }
    }
    
    @Override
    @Async
    public void importUpdateFromExcel(MultipartFile file) {
        List<Pair<String, ProductUpdateRequest>> requests = excelProdHelper.parseUpdateExcel(file);

        for (Pair<String, ProductUpdateRequest> pair : requests) {
            String code = pair.getFirst();
            ProductUpdateRequest request = pair.getSecond();
            try {
            	asyncUpdate(code, request);
                log.info("Cập nhật sản phẩm {} thành công!", code);
            } catch (AppException e) {
                log.error("Lỗi khi cập nhật sản phẩm {}: {}", code, e.getErrorCode().getMessage());
            } catch (Exception e) {
                log.error("Lỗi không xác định khi cập nhật sản phẩm {}: {}", code, e.getMessage());
            }
        }
    }
    
    @Async
    public void asyncUpdate(String code, ProductUpdateRequest request) {
        try {
            productService.updateImport(code, request);
            log.info("Cập nhật sản phẩm {} thành công!", code);
        } catch (AppException e) {
            log.error("Lỗi khi cập nhật sản phẩm {}: {}", code, e.getErrorCode().getMessage());
        }
    }
}
