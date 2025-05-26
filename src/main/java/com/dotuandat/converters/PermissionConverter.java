package com.dotuandat.converters;

import com.dotuandat.dtos.request.permission.PermissionRequest;
import com.dotuandat.dtos.response.permission.PermissionResponse;
import com.dotuandat.entities.Permission;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PermissionConverter {
    @Autowired
    private ModelMapper modelMapper;

    public PermissionResponse toResponse(Permission permission) {
        return modelMapper.map(permission, PermissionResponse.class);
    }

    public Permission toEntity(PermissionRequest permissionRequest) {
        return modelMapper.map(permissionRequest, Permission.class);
    }
}
