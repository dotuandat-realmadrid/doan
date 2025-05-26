package com.dotuandat.converters;

import com.dotuandat.dtos.request.supplier.SupplierCreateRequest;
import com.dotuandat.dtos.response.supplier.SupplierResponse;
import com.dotuandat.entities.Supplier;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SupplierConverter {

    @Autowired
    private ModelMapper modelMapper;

    public SupplierResponse toResponse(Supplier supplier) {
        return modelMapper.map(supplier, SupplierResponse.class);
    }

    public Supplier toEntity(SupplierCreateRequest request) {
        return modelMapper.map(request, Supplier.class);
    }
}
