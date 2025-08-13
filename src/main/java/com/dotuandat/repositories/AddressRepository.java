package com.dotuandat.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.Address;

public interface AddressRepository extends JpaRepository<Address, String> {

    List<Address> findAllByUser_IdAndIsActive(String id, byte isActive);

    boolean existsByKey(String key);

    Address findByKey(String key);
}
