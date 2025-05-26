package com.dotuandat.services;

import java.util.List;

import com.dotuandat.dtos.request.supplier.SupplierCreateRequest;
import com.dotuandat.dtos.request.supplier.SupplierUpdateRequest;
import com.dotuandat.dtos.response.supplier.SupplierResponse;

public interface SupplierService {
    List<SupplierResponse> getAll();

    SupplierResponse create(SupplierCreateRequest request);

    SupplierResponse update(String code, SupplierUpdateRequest request);

    void delete(String code);
}
