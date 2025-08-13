package com.dotuandat.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.CartItem;

public interface CartItemRepository extends JpaRepository<CartItem, String> {
    Optional<CartItem> findByCart_IdAndProduct_Id(String cartId, String productId);

    void deleteByCart_IdAndProduct_Id(String cartId, String productId);
}
