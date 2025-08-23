package com.dotuandat.services;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.request.order.OrderRequest;
import com.dotuandat.dtos.request.order.OrderSearchRequest;
import com.dotuandat.dtos.request.order.OrderStatusRequest;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.order.OrderResponse;
import com.dotuandat.enums.OrderStatus;

public interface OrderService {
    PageResponse<OrderResponse> search(OrderSearchRequest request, Pageable pageable);

    OrderResponse create(OrderRequest request, OrderStatus status);

    OrderResponse createWithId(String id, OrderRequest request, OrderStatus status);

    OrderResponse getOneByOrderId(String orderId);

    OrderResponse getByIdAndEmail(String id, String email);

    PageResponse<OrderResponse> getByUser(OrderStatus status, String userId, Pageable pageable);

    OrderResponse cancel(String orderId);

    PageResponse<OrderResponse> getAllByStatus(OrderStatus status, Pageable pageable);

    OrderResponse updateStatus(String orderId, OrderStatusRequest request);

    int countTotalPendingOrders();
}
