package com.dotuandat.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.dotuandat.entities.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, String>, JpaSpecificationExecutor<User> {
    Optional<User> findByUsername(String username);

    Optional<User> findByUsernameAndIsActive(String username, byte status);

    Optional<User> findByIdAndIsActive(String id, byte status);

    boolean existsByUsername(String username);
}