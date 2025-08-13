package com.dotuandat.dtos.response.role;

import java.util.List;

import com.dotuandat.dtos.response.permission.PermissionResponse;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class RoleResponse {
    String code;
    String description;
    List<PermissionResponse> permissions;
}
