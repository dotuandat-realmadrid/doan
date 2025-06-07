package com.dotuandat.services;

import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.product.ProductResponse;
import org.springframework.data.domain.Pageable;

public interface WishListService {
    PageResponse<ProductResponse> getWishListByUser(String userId, Pageable pageable);

    void toggle(String userId, String productId);
}
