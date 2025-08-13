package com.dotuandat.dtos.response.category;

import java.util.List;

import com.dotuandat.dtos.response.supplier.SupplierResponse;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CategoryResponse {
    String code;
    String name;
    List<SupplierResponse> suppliers;
}
