package com.dotuandat.services.impl;

import com.dotuandat.constants.StatusConstant;
import com.dotuandat.converters.CategoryConverter;
import com.dotuandat.dtos.request.category.CategoryCreateRequest;
import com.dotuandat.dtos.request.category.CategoryUpdateRequest;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.category.CategoryResponse;
import com.dotuandat.entities.Category;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.CategoryRepository;
import com.dotuandat.services.CategoryService;
import com.dotuandat.services.CategoryTrashBinService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CategoryServiceImpl implements CategoryService {
    CategoryRepository categoryRepository;
    CategoryConverter categoryConverter;
    CategoryTrashBinService categoryTrashBinService;

    @Override
    public List<CategoryResponse> getAll() {
        Sort sort = Sort.by(Sort.Direction.ASC, "code");

        return categoryRepository.findAllByIsActive(StatusConstant.ACTIVE, sort).stream()
                .map(categoryConverter::toResponse)
                .toList();
    }
    
    @Override
    public PageResponse<CategoryResponse> search(Pageable pageable) {
        try {
            // Tạo Sort và kết hợp với Pageable
            Sort sort = Sort.by(Sort.Direction.ASC, "code");
            Pageable pageableWithSort = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);

            // Lấy dữ liệu từ database với phân trang
            Page<Category> categories = categoryRepository.findAllByIsActive(StatusConstant.ACTIVE, pageableWithSort);

            // Chuyển đổi từ Category entity sang CategoryResponse DTO
            List<CategoryResponse> categoryResponses = categories.stream()
                .map(categoryConverter::toResponse)
                .collect(Collectors.toList());

            // Tạo và trả về PageResponse
            return PageResponse.<CategoryResponse>builder()
                .totalPage(categories.getTotalPages())
                .currentPage(pageable.getPageNumber() + 1)
                .pageSize(pageable.getPageSize())
                .totalElements(categories.getTotalElements())
                .data(categoryResponses)
                .build();

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tìm kiếm category: ", e);
        }
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
        
        categoryTrashBinService.create(category);
    }
    
    @Override
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public List<String> findAllByCategoryCodes() {
        return categoryRepository.findAllCategoryCodes();
    }

}
