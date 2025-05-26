package com.dotuandat.services;

import java.util.List;

import com.dotuandat.dtos.request.category.CategoryCreateRequest;
import com.dotuandat.dtos.request.category.CategoryUpdateRequest;
import com.dotuandat.dtos.response.category.CategoryResponse;

public interface CategoryService {
    List<CategoryResponse> getAll();

    CategoryResponse create(CategoryCreateRequest request);

    CategoryResponse update(String code, CategoryUpdateRequest request);

    void delete(String code);
}