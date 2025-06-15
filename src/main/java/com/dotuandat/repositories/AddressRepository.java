package com.dotuandat.repositories;

import com.dotuandat.entities.Address;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AddressRepository extends JpaRepository<Address, String> {
	
    List<Address> findAllByUser_IdAndIsActive(String id, byte isActive);

    boolean existsByKey(String key);

    Address findByKey(String key);
}
