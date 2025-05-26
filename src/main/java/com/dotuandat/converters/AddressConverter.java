package com.dotuandat.converters;

import com.dotuandat.constants.StatusConstant;
import com.dotuandat.dtos.request.address.AddressCreateRequest;
import com.dotuandat.dtos.request.address.AddressUpdateRequest;
import com.dotuandat.dtos.response.address.AddressResponse;
import com.dotuandat.entities.Address;
import com.dotuandat.entities.User;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.UserRepository;
import com.dotuandat.utils.AddressUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AddressConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private UserRepository userRepository;

    // create
    public Address toEntity(AddressCreateRequest request) {
        User user = userRepository.findByIdAndIsActive(request.getUserId(), StatusConstant.ACTIVE)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        Address address = modelMapper.map(request, Address.class);
        address.setUser(user);
        address.setKey(AddressUtils.generateUniqueAddressKey(address));

        return address;
    }

    // update
    public Address toEntity(Address address, AddressUpdateRequest request) {
        modelMapper.map(request, address);
        address.setKey(AddressUtils.generateUniqueAddressKey(address));
        return address;
    }

    public AddressResponse toResponse(Address address) {
        AddressResponse response = modelMapper.map(address, AddressResponse.class);
        response.setUserId(address.getUser().getId());
        return response;
    }
}
