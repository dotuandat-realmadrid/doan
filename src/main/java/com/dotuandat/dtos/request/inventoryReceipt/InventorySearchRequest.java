package com.dotuandat.dtos.request.inventoryReceipt;

import java.time.LocalDate;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class InventorySearchRequest {
    String id;
    String email;
    LocalDate startDate;
    LocalDate endDate;
}
