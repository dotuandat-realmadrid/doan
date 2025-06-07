package com.dotuandat.services.impl;

import com.dotuandat.dtos.request.product.ProductCreateRequest;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.services.ProductImportService;
import com.dotuandat.services.ProductService;
import com.dotuandat.utils.ExcelProdHelper;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
    public void importFromExcel(MultipartFile file) {
        List<ProductCreateRequest> requests = excelProdHelper.parseExcel(file);

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
}
