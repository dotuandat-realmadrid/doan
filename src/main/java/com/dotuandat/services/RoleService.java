package com.dotuandat.services;

import java.util.List;

import com.dotuandat.dtos.request.role.RoleRequest;
import com.dotuandat.dtos.response.role.RoleResponse;

public interface RoleService {
    List<RoleResponse> getAll();

    RoleResponse createOrUpdate(RoleRequest request);

    void delete(List<String> codes);
}
