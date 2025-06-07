package com.dotuandat.repositories;

import com.dotuandat.entities.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, String> {
    boolean existsByOrderIdAndProductId(String orderId, String productId);
}
