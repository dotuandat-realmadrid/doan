package com.dotuandat.entities;

import java.time.LocalDateTime;
import java.util.UUID;

import jakarta.persistence.*;

import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.security.core.context.SecurityContextHolder;

import lombok.*;
import lombok.experimental.FieldDefaults;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class BaseEntity {
    @Id
    @Column(columnDefinition = "VARCHAR(36)")
    String id;

    @CreatedDate
    @Column(name = "createddate")
    LocalDateTime createdDate;

    @CreatedBy
    @Column(name = "createdby")
    String createdBy;

    @LastModifiedDate
    @Column(name = "modifieddate")
    LocalDateTime modifiedDate;

    @LastModifiedBy
    @Column(name = "modifiedby")
    String modifiedBy;

    @Builder.Default
    byte isActive = 1;

    @PrePersist
    protected void generateIdIfNeeded() {

        String username = SecurityContextHolder.getContext().getAuthentication().getName();

        if (this.id == null || this.id.trim().isEmpty()) {
            this.id = UUID.randomUUID().toString();
        }

        if (this.createdDate == null) {
            this.createdDate = LocalDateTime.now();
        }

        if (this.modifiedDate == null) {
            this.modifiedDate = LocalDateTime.now();
        }

        if (this.createdBy == null || this.createdBy.trim().isEmpty()) {
            this.createdBy = username;
        }

        if (this.modifiedBy == null || this.modifiedBy.trim().isEmpty()) {
            this.modifiedBy = username;
        }
    }
}
