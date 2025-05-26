package com.dotuandat.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import lombok.experimental.SuperBuilder;

import java.util.List;

@Entity
@Table(name = "permission")
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Permission extends BaseEntity {
    @Column(nullable = false, unique = true)
    String code;

    String description;

    Integer sortOrder;

    @ManyToMany(mappedBy = "permissions")
    List<Role> roles;
}