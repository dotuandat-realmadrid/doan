package com.dotuandat.services.impl;

import com.dotuandat.converters.PermissionConverter;
import com.dotuandat.dtos.request.permission.PermissionRequest;
import com.dotuandat.dtos.response.permission.PermissionResponse;
import com.dotuandat.entities.Permission;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.PermissionRepository;
import com.dotuandat.services.PermissionService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PermissionServiceImpl implements PermissionService {

    PermissionRepository permissionRepository;
    PermissionConverter permissionConverter;

    public List<PermissionResponse> getAll() {
        return permissionRepository.findAll()
                .stream()
                .map(permissionConverter::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public PermissionResponse createOrUpdate(PermissionRequest request) {
        String id = request.getId();

        if (id == null && permissionRepository.existsByCode(request.getCode())) {
            throw new AppException(ErrorCode.PERMISSION_EXISTED);
        } else if (id != null && !permissionRepository.existsById(id)) {
            throw new AppException(ErrorCode.PERMISSION_NOT_EXISTED);
        }

        Permission permission = permissionConverter.toEntity(request);
        permissionRepository.save(permission);

        return permissionConverter.toResponse(permission);
    }

    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public void delete(List<String> codes) {
        if (permissionRepository.existsByCodeInAndRolesIsNotEmpty(codes)) {
            throw new AppException(ErrorCode.INVALID_DELETE_PERMISSION);
        }

        codes.forEach(code -> {
            if (!permissionRepository.existsByCode(code)) {
                throw new AppException(ErrorCode.PERMISSION_NOT_EXISTED);
            }
        });

        permissionRepository.deleteByCodeIn(codes);
    }
}
