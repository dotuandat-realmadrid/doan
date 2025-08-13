package com.dotuandat.services;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.trash.SupplierTrashBinResponse;
import com.dotuandat.entities.Supplier;
import com.dotuandat.entities.SupplierTrashBin;

public interface SupplierTrashBinService {

    PageResponse<SupplierTrashBinResponse> search(Pageable pageable);

    SupplierTrashBin create(Supplier supplier);

    void restore(List<String> supplierIds);
}
