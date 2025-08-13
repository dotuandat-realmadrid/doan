package com.dotuandat.services;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.request.review.ReviewRequest;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.review.ReviewResponse;

public interface ReviewService {
    ReviewResponse create(ReviewRequest request);

    PageResponse<ReviewResponse> getByProductId(String productId, Pageable pageable);

    void delete(String id);
}
