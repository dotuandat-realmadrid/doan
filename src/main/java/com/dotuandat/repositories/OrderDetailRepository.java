package com.dotuandat.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.OrderDetail;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, String> {
    boolean existsByOrderIdAndProductId(String orderId, String productId);
}
