package com.dotuandat.dtos.response.trash;

import java.time.LocalDateTime;

import com.dotuandat.dtos.response.supplier.SupplierResponse;

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
public class SupplierTrashBinResponse {
    String id;
    SupplierResponse supplier;
    LocalDateTime deletedDate;
    String remainingTime;
}