package com.dotuandat.services.impl;

import com.dotuandat.converters.RoleConverter;
import com.dotuandat.dtos.request.role.RoleRequest;
import com.dotuandat.dtos.response.role.RoleResponse;
import com.dotuandat.entities.Role;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.RoleRepository;
import com.dotuandat.services.RoleService;
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
public class RoleServiceImpl implements RoleService {
    RoleConverter roleConverter;
    RoleRepository roleRepository;

    @Override
    public List<RoleResponse> getAll() {
        return roleRepository.findAll()
                .stream()
                .map(roleConverter::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public RoleResponse createOrUpdate(RoleRequest request) {
        String id = request.getId();

        if (id == null && roleRepository.existsByCode(request.getCode())) {
            throw new AppException(ErrorCode.ROLE_EXISTED);
        } else if (id != null && !roleRepository.existsById(id)) {
            throw new AppException(ErrorCode.ROLE_NOT_EXISTED);
        }

        Role role = roleConverter.toEntity(request);
        roleRepository.save(role);

        return roleConverter.toResponse(role);
    }

    @Override
    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public void delete(List<String> codes) {
        if (roleRepository.existsByCodeInAndUsersIsNotEmpty(codes)) {
            throw new AppException(ErrorCode.INVALID_DELETE_ROLE);
        }

        codes.forEach(code -> {
            if (!roleRepository.existsByCode(code)) {
                throw new AppException(ErrorCode.ROLE_NOT_EXISTED);
            }
        });

        roleRepository.deleteByCodeIn(codes);
    }
}
