package com.dotuandat.repositories;

import com.dotuandat.entities.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, String>, JpaSpecificationExecutor<Product> {
    Optional<Product> findByCodeAndIsActive(String code, byte isActive);

    boolean existsByCode(String code);

    @Query("SELECT p.code FROM Product p")
    List<String> findAllProductCodes();
}
