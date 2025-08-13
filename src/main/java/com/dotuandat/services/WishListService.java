package com.dotuandat.services;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.product.ProductResponse;

public interface WishListService {
    PageResponse<ProductResponse> getWishListByUser(String userId, Pageable pageable);

    void toggle(String userId, String productId);

    boolean checkWishList(String userId, String productId);
}
