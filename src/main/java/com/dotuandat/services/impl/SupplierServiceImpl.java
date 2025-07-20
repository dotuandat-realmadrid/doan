package com.dotuandat.services.impl;

import com.dotuandat.constants.StatusConstant;
import com.dotuandat.converters.SupplierConverter;
import com.dotuandat.dtos.request.supplier.SupplierCreateRequest;
import com.dotuandat.dtos.request.supplier.SupplierUpdateRequest;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.supplier.SupplierResponse;
import com.dotuandat.entities.Supplier;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.SupplierRepository;
import com.dotuandat.services.SupplierService;
import com.dotuandat.services.SupplierTrashBinService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class SupplierServiceImpl implements SupplierService {
    SupplierRepository supplierRepository;
    SupplierConverter supplierConverter;
    SupplierTrashBinService supplierTrashBinService;

    @Override
    public List<SupplierResponse> getAll() {
        Sort sort = Sort.by(Sort.Direction.ASC, "code");

        return supplierRepository.findAllByIsActive(StatusConstant.ACTIVE, sort)
                .stream().map(supplierConverter::toResponse)
                .toList();
    }
    
    @Override
    public PageResponse<SupplierResponse> search(Pageable pageable) {
        try {
            // Tạo Sort và kết hợp với Pageable
            Sort sort = Sort.by(Sort.Direction.ASC, "code");
            Pageable pageableWithSort = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);

            // Lấy dữ liệu từ database với phân trang
            Page<Supplier> categories = supplierRepository.findAllByIsActive(StatusConstant.ACTIVE, pageableWithSort);

            // Chuyển đổi từ Category entity sang CategoryResponse DTO
            List<SupplierResponse> categoryResponses = categories.stream()
                .map(supplierConverter::toResponse)
                .collect(Collectors.toList());

            // Tạo và trả về PageResponse
            return PageResponse.<SupplierResponse>builder()
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
    public SupplierResponse create(SupplierCreateRequest request) {
        if (supplierRepository.existsByCode(request.getCode()))
            throw new AppException(ErrorCode.SUPPLIER_EXISTED);

        Supplier supplier = supplierConverter.toEntity(request);
        supplierRepository.save(supplier);

        return supplierConverter.toResponse(supplier);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public SupplierResponse update(String code, SupplierUpdateRequest request) {
        Supplier supplier = supplierRepository.findByCode(code)
                .orElseThrow(() -> new AppException(ErrorCode.SUPPLIER_NOT_EXISTED));

        supplier.setName(request.getName());
        supplierRepository.save(supplier);

        return supplierConverter.toResponse(supplier);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public void delete(String code) {
        Supplier supplier = supplierRepository.findByCode(code)
                .orElseThrow(() -> new AppException(ErrorCode.SUPPLIER_NOT_EXISTED));

        supplier.setIsActive(StatusConstant.INACTIVE);
        supplierRepository.save(supplier);
        
        supplierTrashBinService.create(supplier);
    }

    @Override
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public List<String> findAllSupplierCodes() {
    	return supplierRepository.findAllSupplierCodes();
    }
}
