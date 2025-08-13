package com.dotuandat.dtos.request.order;

import java.time.LocalDate;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class OrderSearchRequest {
    String id;
    String email;
    String fullName;
    String phone;
    LocalDate startDate;
    LocalDate endDate;
}
