package com.dotuandat.controllers;

import jakarta.validation.Valid;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dotuandat.dtos.request.order.RefundRequest;
import com.dotuandat.dtos.request.order.RefundStatusRequest;
import com.dotuandat.dtos.response.ApiResponse;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.order.RefundResponse;
import com.dotuandat.enums.RefundStatus;
import com.dotuandat.services.RefundService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RestController
@RequestMapping("/refunds")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RefundController {
    RefundService refundService;

    @GetMapping("/search")
    public ApiResponse<PageResponse<RefundResponse>> search(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdDate").and(Sort.by(Sort.Direction.ASC, "id"));

        Pageable pageable = PageRequest.of(page - 1, size, sort);

        return ApiResponse.<PageResponse<RefundResponse>>builder()
                .result(refundService.search(pageable))
                .build();
    }

    @PostMapping
    public ApiResponse<RefundResponse> create(@RequestBody @Valid RefundRequest request) {
        return ApiResponse.<RefundResponse>builder()
                .result(refundService.create(request, RefundStatus.PENDING))
                .build();
    }

    @GetMapping("/status/{status}")
    public ApiResponse<PageResponse<RefundResponse>> getAllByStatus(
            @PathVariable RefundStatus status,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdDate").and(Sort.by(Sort.Direction.ASC, "id"));

        Pageable pageable = PageRequest.of(page - 1, size, sort);

        return ApiResponse.<PageResponse<RefundResponse>>builder()
                .result(refundService.getAllByStatus(status, pageable))
                .build();
    }

    @GetMapping("/{id}")
    public ApiResponse<RefundResponse> getById(@PathVariable String id) {
        return ApiResponse.<RefundResponse>builder()
                .result(refundService.getById(id))
                .build();
    }

    @GetMapping("/user/{userId}/status/{status}")
    public ApiResponse<PageResponse<RefundResponse>> getByUser(
            @PathVariable(value = "status") RefundStatus status,
            @PathVariable(value = "userId") String userId,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdDate").and(Sort.by(Sort.Direction.ASC, "id"));

        Pageable pageable = PageRequest.of(page - 1, size, sort);

        return ApiResponse.<PageResponse<RefundResponse>>builder()
                .result(refundService.getByUser(status, userId, pageable))
                .build();
    }

    @PatchMapping("/{id}/status")
    public ApiResponse<RefundResponse> updateStatus(
            @PathVariable String id, @RequestBody @Valid RefundStatusRequest request) {
        return ApiResponse.<RefundResponse>builder()
                .result(refundService.updateStatus(id, request))
                .build();
    }

    @GetMapping("/status/PENDING/count")
    public ApiResponse<Integer> countTotalPendingRefunds() {
        return ApiResponse.<Integer>builder()
                .result(refundService.countTotalPendingRefunds())
                .build();
    }
}
