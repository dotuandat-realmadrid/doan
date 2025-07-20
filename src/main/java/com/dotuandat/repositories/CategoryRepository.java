package com.dotuandat.repositories;

import com.dotuandat.entities.Category;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface CategoryRepository extends JpaRepository<Category, String> {
    List<Category> findAllByIsActive(Byte isActive, Sort sort);
    
    @Query("SELECT c FROM Category c WHERE c.isActive = :isActive")
    Page<Category> findAllByIsActive(@Param("isActive") Byte isActive, Pageable pageable);
    
    Optional<Category> findByCode(String code);

    boolean existsByCode(String code);

    @Query("SELECT c.code FROM Category c")
    List<String> findAllCategoryCodes();
}
