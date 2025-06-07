package com.dotuandat.repositories;

import com.dotuandat.entities.InventoryReceipt;
import com.dotuandat.enums.InventoryStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface InventoryReceiptRepository extends JpaRepository<InventoryReceipt, String>,
        JpaSpecificationExecutor<InventoryReceipt> {
    Page<InventoryReceipt> findAllByStatus(InventoryStatus status, Pageable pageable);

    int countByStatus(InventoryStatus status);
}
