package com.dotuandat.controllers;

import com.dotuandat.dtos.request.role.RoleRequest;
import com.dotuandat.dtos.response.ApiResponse;
import com.dotuandat.dtos.response.role.RoleResponse;
import com.dotuandat.services.RoleService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/roles")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RoleController {
    RoleService roleService;

    @GetMapping
    public ApiResponse<List<RoleResponse>> getAll() {
        return ApiResponse.<List<RoleResponse>>builder()
                .result(roleService.getAll())
                .build();
    }

    @PostMapping
    public ApiResponse<RoleResponse> createOrUpdate(@RequestBody @Valid RoleRequest request) {
        return ApiResponse.<RoleResponse>builder()
                .result(roleService.createOrUpdate(request))
                .build();
    }

    @DeleteMapping("/{codes}")
    public ApiResponse<Void> delete(@PathVariable List<String> codes) {
        roleService.delete(codes);

        return ApiResponse.<Void>builder()
                .message("Delete successfully")
                .build();
    }
}
