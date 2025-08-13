package com.dotuandat.repositories;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.dotuandat.entities.UserTrashBin;

public interface UserTrashBinRepository extends JpaRepository<UserTrashBin, String> {
    List<UserTrashBin> findByDeletedDateBefore(LocalDateTime time);

    @Query("SELECT utb FROM UserTrashBin utb WHERE utb.user.id = :userId ORDER BY utb.deletedDate DESC")
    Optional<UserTrashBin> findByUserId(@Param("userId") String userId);
}
