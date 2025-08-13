package com.dotuandat.dtos.response.home;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ActivityLogResponse {
    private String id;
    private String username;
    private String actionType;
    private String description;
    private LocalDateTime timestamp;
}
