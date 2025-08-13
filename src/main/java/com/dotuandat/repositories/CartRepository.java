package com.dotuandat.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.Cart;

public interface CartRepository extends JpaRepository<Cart, String> {
    Optional<Cart> findByUser_Id(String user_Id);
}
