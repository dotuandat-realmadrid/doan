package com.dotuandat.repositories;

import com.dotuandat.entities.Discount;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DiscountRepository extends JpaRepository<Discount, String> {
	
	List<Discount> findAllByIsActive(Byte isActive, Sort sort);
}
