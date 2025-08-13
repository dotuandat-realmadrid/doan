package com.dotuandat.services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.response.home.ActivityLogResponse;

public interface ActivityLogService {

    ActivityLogResponse create(String username, String actionType, String description);

    List<ActivityLogResponse> findRecentActivities(LocalDateTime startDate, LocalDateTime endDate, Pageable pageable);
}
