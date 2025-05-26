package com.dotuandat.converters;

import com.dotuandat.dtos.request.category.CategoryCreateRequest;
import com.dotuandat.dtos.request.category.CategoryUpdateRequest;
import com.dotuandat.dtos.response.category.CategoryResponse;
import com.dotuandat.entities.Category;
import com.dotuandat.entities.Supplier;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.SupplierRepository;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class CategoryConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private SupplierRepository supplierRepository;

    @Autowired
    private SupplierConverter supplierConverter;

    public CategoryResponse toResponse(Category category) {
        CategoryResponse response = modelMapper.map(category, CategoryResponse.class);

        Sort sort = Sort.by(Sort.Direction.ASC, "code");
        List<Supplier> suppliers = supplierRepository.findAllByCategories_Code(category.getCode(), sort);

        response.setSuppliers(suppliers.stream().map(supplierConverter::toResponse).toList());

        return response;
    }

    public Category toEntity(CategoryCreateRequest request) {
        Category category = modelMapper.map(request, Category.class);

        List<Supplier> suppliers = getSuppliers(request.getSupplierCodes());
        category.setSuppliers(suppliers);

        return category;
    }

    public Category toEntity(Category existedCategory, CategoryUpdateRequest request) {
        modelMapper.map(request, existedCategory);

        List<Supplier> suppliers = getSuppliers(request.getSupplierCodes());
        existedCategory.setSuppliers(suppliers);

        return existedCategory;
    }

    private List<Supplier> getSuppliers(List<String> supplierCodes) {
        return supplierCodes.stream()
                .map(id -> supplierRepository.findByCode(id)
                        .orElseThrow(() -> new AppException(ErrorCode.SUPPLIER_NOT_EXISTED)))
                .collect(Collectors.toList());
    }
}
