package com.dotuandat.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.dotuandat.entities.Supplier;

public interface SupplierRepository extends JpaRepository<Supplier, String> {
    List<Supplier> findAllByIsActive(Byte isActive, Sort sort);

    List<Supplier> findAllByCategories_Code(String categoriesCode, Sort sort);
    
    @Query("SELECT s FROM Supplier s WHERE s.isActive = :isActive")
    Page<Supplier> findAllByIsActive(@Param("isActive") Byte isActive, Pageable pageable);

    Optional<Supplier> findByCode(String code);

    boolean existsByCode(String code);

    @Query("SELECT s.code FROM Supplier s")
    List<String> findAllSupplierCodes();
}
