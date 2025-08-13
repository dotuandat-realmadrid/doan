package com.dotuandat.services.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.dotuandat.dtos.response.home.ActivityLogResponse;
import com.dotuandat.entities.ActivityLog;
import com.dotuandat.repositories.ActivityLogRepository;
import com.dotuandat.services.ActivityLogService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ActivityLogServiceImpl implements ActivityLogService {

    ActivityLogRepository activityLogRepository;
    ModelMapper modelMapper;

    @Override
    public ActivityLogResponse create(String username, String actionType, String description) {
        if (!StringUtils.hasText(username) || !StringUtils.hasText(actionType) || !StringUtils.hasText(description)) {
            log.error(
                    "Invalid input for activity log: username={}, actionType={}, description={}",
                    username,
                    actionType,
                    description);
            throw new IllegalArgumentException("Username, actionType, and description must not be empty");
        }

        ActivityLog activityLog = ActivityLog.builder()
                .username(username)
                .actionType(actionType)
                .description(description)
                .timestamp(LocalDateTime.now())
                .build();

        try {
            ActivityLog savedLog = activityLogRepository.save(activityLog);
            log.info("Activity log created: id={}, username={}, actionType={}", savedLog.getId(), username, actionType);
            return modelMapper.map(savedLog, ActivityLogResponse.class);
        } catch (Exception e) {
            log.error("Failed to save activity log: {}", e.getMessage());
            throw new RuntimeException("Could not save activity log", e);
        }
    }

    @Override
    public List<ActivityLogResponse> findRecentActivities(
            LocalDateTime startDate, LocalDateTime endDate, Pageable pageable) {
        if (startDate == null || endDate == null || pageable == null) {
            log.error("Invalid parameters: startDate={}, endDate={}, pageable={}", startDate, endDate, pageable);
            throw new IllegalArgumentException("startDate, endDate, and pageable must not be null");
        }

        List<ActivityLog> logs = activityLogRepository.findRecentActivities(startDate, endDate, pageable);
        log.info("Retrieved {} recent activities from {} to {}", logs.size(), startDate, endDate);
        return logs.stream()
                .map(log -> modelMapper.map(log, ActivityLogResponse.class))
                .collect(Collectors.toList());
    }
}
