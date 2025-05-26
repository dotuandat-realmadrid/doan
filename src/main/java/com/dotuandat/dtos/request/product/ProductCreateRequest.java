package com.dotuandat.dtos.request.product;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductCreateRequest {
    @NotBlank(message = "CATEGORY_NOT_BLANK")
    String categoryCode;

    @NotBlank(message = "SUPPLIER_NOT_BLANK")
    String supplierCode;

    @NotBlank(message = "CODE_NOT_BLANK")
    String code;

    @NotBlank(message = "NAME_NOT_BLANK")
    String name;

    String description;

    @NotNull(message = "PRICE_NOT_NULL")
    @Min(value = 1000, message = "MIN_PRICE")
    long price;
}
