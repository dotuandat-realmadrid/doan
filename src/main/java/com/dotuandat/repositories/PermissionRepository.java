package com.dotuandat.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.Permission;

public interface PermissionRepository extends JpaRepository<Permission, String> {
    boolean existsByCode(String code);

    Permission findByCode(String code);

    void deleteByCodeIn(List<String> code);

    boolean existsByCodeInAndRolesIsNotEmpty(List<String> codes);
}