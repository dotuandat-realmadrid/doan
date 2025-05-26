package com.dotuandat.dtos.response.role;

import com.dotuandat.dtos.response.permission.PermissionResponse;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

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
