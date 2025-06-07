package com.dotuandat.services;

import com.dotuandat.dtos.request.cart.CartItemRequest;
import com.dotuandat.dtos.response.cart.CartResponse;

public interface CartService {
    int getTotalItems(String userId);

    CartResponse getCartByUser(String userId);

    void clearCart(String userId);

    CartResponse addCartItem(CartItemRequest request);

    void removeItem(String userId, String productId);
}
