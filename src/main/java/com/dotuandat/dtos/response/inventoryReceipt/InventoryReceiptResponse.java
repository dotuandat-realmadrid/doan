package com.dotuandat.dtos.response.inventoryReceipt;

import java.time.LocalDateTime;
import java.util.List;

import com.dotuandat.enums.InventoryStatus;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InventoryReceiptResponse {
    String id;
    long totalAmount;
    InventoryStatus status;
    String note;
    LocalDateTime createdDate;
    String createdBy;
    LocalDateTime modifiedDate;
    String modifiedBy;
    List<InventoryReceiptDetailResponse> detailResponses;
}
