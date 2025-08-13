package com.dotuandat.repositories;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.Discount;

public interface DiscountRepository extends JpaRepository<Discount, String> {

    List<Discount> findAllByIsActive(Byte isActive, Sort sort);
}
