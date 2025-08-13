package com.dotuandat.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.InvalidatedToken;

public interface InvalidatedTokenRepository extends JpaRepository<InvalidatedToken, String> {}
