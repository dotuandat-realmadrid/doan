package com.dotuandat.dtos.response.report;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SupplierReport {
    String supplierName;
    long totalSoldQuantity;
    long totalRevenue;
}
