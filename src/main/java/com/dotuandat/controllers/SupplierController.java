package com.dotuandat.controllers;

import java.util.List;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

import com.dotuandat.dtos.request.supplier.SupplierCreateRequest;
import com.dotuandat.dtos.request.supplier.SupplierUpdateRequest;
import com.dotuandat.dtos.response.ApiResponse;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.supplier.SupplierResponse;
import com.dotuandat.services.SupplierService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RestController
@RequestMapping("/suppliers")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class SupplierController {
    SupplierService supplierService;

    @GetMapping
    public ApiResponse<List<SupplierResponse>> getAll() {
        return ApiResponse.<List<SupplierResponse>>builder()
                .result(supplierService.getAll())
                .build();
    }

    @GetMapping("/search")
    public ApiResponse<PageResponse<SupplierResponse>> search(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "20") int size) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdDate").and(Sort.by(Sort.Direction.ASC, "id"));

        Pageable pageable = PageRequest.of(page - 1, size, sort);

        return ApiResponse.<PageResponse<SupplierResponse>>builder()
                .result(supplierService.search(pageable))
                .build();
    }

    @PostMapping
    public ApiResponse<SupplierResponse> create(@RequestBody SupplierCreateRequest request) {
        return ApiResponse.<SupplierResponse>builder()
                .result(supplierService.create(request))
                .build();
    }

    @PutMapping("/{code}")
    public ApiResponse<SupplierResponse> update(@PathVariable String code, @RequestBody SupplierUpdateRequest request) {
        return ApiResponse.<SupplierResponse>builder()
                .result(supplierService.update(code, request))
                .build();
    }

    @DeleteMapping("/{code}")
    public ApiResponse<Void> delete(@PathVariable String code) {
        supplierService.delete(code);

        return ApiResponse.<Void>builder().message("Delete successfully").build();
    }

    @GetMapping("/code")
    public ApiResponse<List<String>> getAllSupplierCodes() {
        return ApiResponse.<List<String>>builder()
                .result(supplierService.findAllSupplierCodes())
                .build();
    }
}
