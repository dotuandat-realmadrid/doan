package com.dotuandat.services;

import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.entities.Contact;
import org.springframework.data.domain.Pageable;

public interface ContactService {
    Contact create(Contact contact);

    PageResponse<Contact> getByIsRead(boolean isRead, Pageable pageable);

    void markAsRead(String id);

    int countUnreadContacts();
}
