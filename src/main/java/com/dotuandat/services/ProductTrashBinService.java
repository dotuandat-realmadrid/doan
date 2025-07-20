package com.dotuandat.services;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.trash.ProductTrashBinResponse;
import com.dotuandat.entities.Product;
import com.dotuandat.entities.ProductTrashBin;

public interface ProductTrashBinService {

	PageResponse<ProductTrashBinResponse> search(Pageable pageable);

	List<ProductTrashBin> create(List<Product> products);

	void restore(List<String> productIds);

}
