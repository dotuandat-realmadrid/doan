package com.dotuandat.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.Role;

public interface RoleRepository extends JpaRepository<Role, String> {
    List<Role> findByUsers_Id(String id);

    Role findByCode(String code);

    boolean existsByCode(String code);

    void deleteByCodeIn(List<String> codes);

    boolean existsByCodeInAndUsersIsNotEmpty(List<String> codes);
}
