package com.dotuandat.services;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.request.product.ProductCreateRequest;
import com.dotuandat.dtos.request.product.ProductSearchRequest;
import com.dotuandat.dtos.request.product.ProductUpdateRequest;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.product.ProductResponse;

public interface ProductService {
    PageResponse<ProductResponse> search(ProductSearchRequest request, Pageable pageable);

    ProductResponse getByCode(String code);

    ProductResponse create(ProductCreateRequest request);

    ProductResponse update(String id, ProductUpdateRequest request);

    void saveProductImages(String id, List<String> fileNames);

    void updateProductImages(String id, List<String> keepImages, List<String> newFileNames);

	void delete(List<String> ids);
}
