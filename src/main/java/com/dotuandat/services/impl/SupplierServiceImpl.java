package com.dotuandat.services.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
import com.dotuandat.services.ActivityLogService;
import com.dotuandat.services.SupplierService;
import com.dotuandat.services.SupplierTrashBinService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class SupplierServiceImpl implements SupplierService {
    SupplierRepository supplierRepository;
    SupplierConverter supplierConverter;
    SupplierTrashBinService supplierTrashBinService;
    ActivityLogService activityLogService;

    @Override
    public List<SupplierResponse> getAll() {
        Sort sort = Sort.by(Sort.Direction.ASC, "code");

        return supplierRepository.findAllByIsActive(StatusConstant.ACTIVE, sort).stream()
                .map(supplierConverter::toResponse)
                .toList();
    }

    @Override
    public PageResponse<SupplierResponse> search(Pageable pageable) {
        try {

            // Lấy dữ liệu từ database với phân trang
            Page<Supplier> suppliers = supplierRepository.findAllByIsActive(StatusConstant.ACTIVE, pageable);

            // Chuyển đổi từ Supplier entity sang SupplierResponse DTO
            List<SupplierResponse> supplierResponses =
                    suppliers.stream().map(supplierConverter::toResponse).collect(Collectors.toList());

            // Tạo và trả về PageResponse
            return PageResponse.<SupplierResponse>builder()
                    .totalPage(suppliers.getTotalPages())
                    .currentPage(pageable.getPageNumber() + 1)
                    .pageSize(pageable.getPageSize())
                    .totalElements(suppliers.getTotalElements())
                    .data(supplierResponses)
                    .build();

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tìm kiếm category: ", e);
        }
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public SupplierResponse create(SupplierCreateRequest request) {
        if (supplierRepository.existsByCode(request.getCode())) throw new AppException(ErrorCode.SUPPLIER_EXISTED);

        Supplier supplier = supplierConverter.toEntity(request);
        supplierRepository.save(supplier);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        activityLogService.create(
                username, "CREATE", "Tài khoản " + username + " vừa thêm nhà cung cấp " + supplier.getName());

        return supplierConverter.toResponse(supplier);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public SupplierResponse update(String code, SupplierUpdateRequest request) {
        Supplier supplier =
                supplierRepository.findByCode(code).orElseThrow(() -> new AppException(ErrorCode.SUPPLIER_NOT_EXISTED));

        supplier.setName(request.getName());
        supplierRepository.save(supplier);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        activityLogService.create(
                username, "UPDATE", "Tài khoản " + username + " vừa cập nhật nhà cung cấp " + supplier.getName());

        return supplierConverter.toResponse(supplier);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public void delete(String code) {
        Supplier supplier =
                supplierRepository.findByCode(code).orElseThrow(() -> new AppException(ErrorCode.SUPPLIER_NOT_EXISTED));

        supplier.setIsActive(StatusConstant.INACTIVE);
        supplierRepository.save(supplier);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        activityLogService.create(
                username, "DELETE", "Tài khoản " + username + " vừa xóa nhà cung cấp " + supplier.getName());

        supplierTrashBinService.create(supplier);
    }

    @Override
    @PreAuthorize("hasAuthority('CUD_CATEGORY_SUPPLIER')")
    public List<String> findAllSupplierCodes() {
        return supplierRepository.findAllSupplierCodes();
    }
}
