package com.dotuandat.services.impl;

import com.dotuandat.constants.StatusConstant;
import com.dotuandat.converters.CategoryConverter;
import com.dotuandat.dtos.request.category.CategoryCreateRequest;
import com.dotuandat.dtos.request.category.CategoryUpdateRequest;
import com.dotuandat.dtos.response.category.CategoryResponse;
import com.dotuandat.entities.Category;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.CategoryRepository;
import com.dotuandat.services.CategoryService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CategoryServiceImpl implements CategoryService {
    CategoryRepository categoryRepository;
    CategoryConverter categoryConverter;

    @Override
    public List<CategoryResponse> getAll() {
        Sort sort = Sort.by(Sort.Direction.ASC, "code");

        return categoryRepository.findAllByIsActive(StatusConstant.ACTIVE, sort).stream()
                .map(categoryConverter::toResponse)
                .toList();
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public CategoryResponse create(CategoryCreateRequest request) {
        if (categoryRepository.existsByCode(request.getCode()))
            throw new AppException(ErrorCode.CATEGORY_EXISTED);

        Category category = categoryConverter.toEntity(request);
        categoryRepository.save(category);

        return categoryConverter.toResponse(category);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public CategoryResponse update(String code, CategoryUpdateRequest request) {
        Category existedCategory = categoryRepository.findByCode(code)
                .orElseThrow(() -> new AppException(ErrorCode.CATEGORY_NOT_EXISTED));

        Category updatedCategory = categoryConverter.toEntity(existedCategory, request);
        categoryRepository.save(updatedCategory);

        return categoryConverter.toResponse(updatedCategory);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public void delete(String code) {
        Category category = categoryRepository.findByCode(code)
                .orElseThrow(() -> new AppException(ErrorCode.CATEGORY_NOT_EXISTED));

        category.setIsActive(StatusConstant.INACTIVE);
        categoryRepository.save(category);
    }
}
