package com.dotuandat.dtos.request.inventoryReceipt;

import com.dotuandat.enums.InventoryStatus;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class InventoryStatusRequest {
    InventoryStatus status;
}
