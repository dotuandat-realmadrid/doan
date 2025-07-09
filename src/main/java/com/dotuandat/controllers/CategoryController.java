package com.dotuandat.controllers;

import com.dotuandat.dtos.request.category.CategoryCreateRequest;
import com.dotuandat.dtos.request.category.CategoryUpdateRequest;
import com.dotuandat.dtos.response.ApiResponse;
import com.dotuandat.dtos.response.category.CategoryResponse;
import com.dotuandat.services.CategoryService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/categories")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CategoryController {
    CategoryService categoryService;

    @GetMapping
    public ApiResponse<List<CategoryResponse>> getAll() {
        return ApiResponse.<List<CategoryResponse>>builder()
                .result(categoryService.getAll())
                .build();
    }

    @PostMapping
    public ApiResponse<CategoryResponse> create(@RequestBody @Valid CategoryCreateRequest request) {
        return ApiResponse.<CategoryResponse>builder()
                .result(categoryService.create(request))
                .build();
    }

    @PutMapping("/{code}")
    public ApiResponse<CategoryResponse> update(@PathVariable String code,
                                                @RequestBody @Valid CategoryUpdateRequest request) {
        return ApiResponse.<CategoryResponse>builder()
                .result(categoryService.update(code, request))
                .build();
    }

    @DeleteMapping("/{code}")
    public ApiResponse<Void> delete(@PathVariable String code) {
        categoryService.delete(code);

        return ApiResponse.<Void>builder()
                .message("Delete successfully")
                .build();
    }
    
    @GetMapping("/code")
    public ApiResponse<List<String>> getAllCateoryCodes() {
    	return ApiResponse.<List<String>>builder()
    			.result(categoryService.findAllByCategoryCodes())
    			.build();
    }
}
