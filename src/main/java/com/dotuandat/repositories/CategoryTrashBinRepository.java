package com.dotuandat.repositories;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.CategoryTrashBin;

public interface CategoryTrashBinRepository extends JpaRepository<CategoryTrashBin, String> {

    List<CategoryTrashBin> findByDeletedDateBefore(LocalDateTime time);
}
