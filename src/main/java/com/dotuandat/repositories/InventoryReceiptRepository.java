package com.dotuandat.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.dotuandat.entities.InventoryReceipt;
import com.dotuandat.enums.InventoryStatus;

public interface InventoryReceiptRepository extends JpaRepository<InventoryReceipt, String>,
        JpaSpecificationExecutor<InventoryReceipt> {
    Page<InventoryReceipt> findAllByStatus(InventoryStatus status, Pageable pageable);

    int countByStatus(InventoryStatus status);
}
