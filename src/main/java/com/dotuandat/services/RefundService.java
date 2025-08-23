package com.dotuandat.services;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.request.order.RefundRequest;
import com.dotuandat.dtos.request.order.RefundStatusRequest;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.order.RefundResponse;
import com.dotuandat.enums.RefundStatus;

public interface RefundService {

    PageResponse<RefundResponse> search(Pageable pageable);

    RefundResponse create(RefundRequest request, RefundStatus status);

    PageResponse<RefundResponse> getAllByStatus(RefundStatus status, Pageable pageable);

    RefundResponse getById(String id);

    PageResponse<RefundResponse> getByUser(RefundStatus status, String userId, Pageable pageable);

    RefundResponse updateStatus(String refundId, RefundStatusRequest request);

    int countTotalPendingRefunds();
}
