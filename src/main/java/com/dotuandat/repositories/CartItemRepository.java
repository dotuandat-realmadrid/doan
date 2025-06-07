package com.dotuandat.repositories;

import com.dotuandat.entities.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CartItemRepository extends JpaRepository<CartItem, String> {
    Optional<CartItem> findByCart_IdAndProduct_Id(String cartId, String productId);

    void deleteByCart_IdAndProduct_Id(String cartId, String productId);
}
