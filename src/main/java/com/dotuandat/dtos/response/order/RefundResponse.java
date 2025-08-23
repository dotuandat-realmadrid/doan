package com.dotuandat.dtos.response.order;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import com.dotuandat.enums.RefundStatus;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class RefundResponse {
    String id;
    String code;
    String userId;
    String username;
    String fullName;
    String phone;
    String address;
    String orderId;
    Long totalPrice;
    BigDecimal refundAmount;
    RefundStatus status;
    String reason;
    LocalDateTime transactionDate;
    LocalDateTime createdDate;
    String note;
    List<OrderDetailResponse> details;
}
