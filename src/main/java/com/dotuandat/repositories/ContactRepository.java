package com.dotuandat.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dotuandat.entities.Contact;

public interface ContactRepository extends JpaRepository<Contact, String> {
    Page<Contact> findAllByIsRead(Boolean isRead, Pageable pageable);

    int countByIsRead(Boolean isRead);
}
