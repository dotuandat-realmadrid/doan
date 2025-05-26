package com.dotuandat.services.impl;

import com.dotuandat.constants.StatusConstant;
import com.dotuandat.converters.SupplierConverter;
import com.dotuandat.dtos.request.supplier.SupplierCreateRequest;
import com.dotuandat.dtos.request.supplier.SupplierUpdateRequest;
import com.dotuandat.dtos.response.supplier.SupplierResponse;
import com.dotuandat.entities.Supplier;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.SupplierRepository;
import com.dotuandat.services.SupplierService;
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
public class SupplierServiceImpl implements SupplierService {
    SupplierRepository supplierRepository;
    SupplierConverter supplierConverter;

    public List<SupplierResponse> getAll() {
        Sort sort = Sort.by(Sort.Direction.ASC, "code");

        return supplierRepository.findAllByIsActive(StatusConstant.ACTIVE, sort)
                .stream().map(supplierConverter::toResponse)
                .toList();
    }

    @Transactional
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public SupplierResponse create(SupplierCreateRequest request) {
        if (supplierRepository.existsByCode(request.getCode()))
            throw new AppException(ErrorCode.SUPPLIER_EXISTED);

        Supplier supplier = supplierConverter.toEntity(request);
        supplierRepository.save(supplier);

        return supplierConverter.toResponse(supplier);
    }

    @Transactional
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public SupplierResponse update(String code, SupplierUpdateRequest request) {
        Supplier supplier = supplierRepository.findByCode(code)
                .orElseThrow(() -> new AppException(ErrorCode.SUPPLIER_NOT_EXISTED));

        supplier.setName(request.getName());
        supplierRepository.save(supplier);

        return supplierConverter.toResponse(supplier);
    }

    @Transactional
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public void delete(String code) {
        Supplier supplier = supplierRepository.findByCode(code)
                .orElseThrow(() -> new AppException(ErrorCode.SUPPLIER_NOT_EXISTED));

        supplier.setIsActive(StatusConstant.INACTIVE);
        supplierRepository.save(supplier);
    }
}
