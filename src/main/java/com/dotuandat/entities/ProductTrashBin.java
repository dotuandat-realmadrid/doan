package com.dotuandat.entities;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "product_trash")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductTrashBin {
    @Id
    @Column(columnDefinition = "VARCHAR(36)")
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    @OneToOne
    @JoinColumn(
            name = "product_id",
            referencedColumnName = "id",
            nullable = false,
            unique = true,
            columnDefinition = "VARCHAR(36)")
    private Product product;

    @Column(name = "deleted_date", nullable = false)
    private LocalDateTime deletedDate = LocalDateTime.now();
}
