package com.dotuandat.services;

import java.util.List;

import com.dotuandat.dtos.request.address.AddressCreateRequest;
import com.dotuandat.dtos.request.address.AddressUpdateRequest;
import com.dotuandat.dtos.response.address.AddressResponse;

public interface AddressService {
	
	List<AddressResponse> getAllByUserId(String userId);

    AddressResponse create(AddressCreateRequest request);

    AddressResponse update(String addressId, AddressUpdateRequest request);

    void delete(String addressId);

	AddressResponse getById(String id);
}
