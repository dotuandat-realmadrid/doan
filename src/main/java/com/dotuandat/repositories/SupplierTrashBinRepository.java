package com.dotuandat.repositories;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.SupplierTrashBin;

public interface SupplierTrashBinRepository extends JpaRepository<SupplierTrashBin, String> {

    List<SupplierTrashBin> findByDeletedDateBefore(LocalDateTime time);
}
