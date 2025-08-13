package com.dotuandat.dtos.request.category;

import java.util.List;

import jakarta.validation.constraints.NotBlank;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class CategoryUpdateRequest {
    @NotBlank(message = "NAME_NOT_BLANK")
    String name;

    List<String> supplierCodes;
}
