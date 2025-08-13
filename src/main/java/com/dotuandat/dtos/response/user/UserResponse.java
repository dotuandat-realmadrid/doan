package com.dotuandat.dtos.response.user;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserResponse {
    String id;
    String username;
    String fullName;
    String phone;
    LocalDate dob;
    LocalDateTime createdDate;
    String createdBy;
    LocalDateTime modifiedDate;
    String modifiedBy;
    byte isActive;
    byte isGuest;
    List<String> roles;

    @Builder.Default
    boolean hasPassword = true;
}
