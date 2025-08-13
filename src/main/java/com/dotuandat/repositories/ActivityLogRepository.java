package com.dotuandat.repositories;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.dotuandat.entities.ActivityLog;

@Repository
public interface ActivityLogRepository extends JpaRepository<ActivityLog, String> {

    @Query(
            """
			SELECT a
			FROM ActivityLog a
			WHERE a.timestamp >= :startDate AND a.timestamp < :endDate
			ORDER BY a.timestamp DESC
			""")
    List<ActivityLog> findRecentActivities(
            @Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate, Pageable pageable);
}
