package com.dotuandat.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.WishList;

public interface WishListRepository extends JpaRepository<WishList, String> {
    Page<WishList> findByUserId(String userId, Pageable pageable);

    boolean existsByUser_IdAndProduct_Id(String userId, String productId);

    void deleteByUser_IdAndProduct_Id(String userId, String productId);
}
