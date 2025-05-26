package com.dotuandat.services;

import java.util.List;

import com.dotuandat.dtos.request.permission.PermissionRequest;
import com.dotuandat.dtos.response.permission.PermissionResponse;

public interface PermissionService {
    List<PermissionResponse> getAll();

    PermissionResponse createOrUpdate(PermissionRequest request);

    void delete(List<String> codes);
}
