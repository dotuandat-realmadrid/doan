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
@Table(name = "discount_trash")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DiscountTrashBin {
    @Id
    @Column(columnDefinition = "VARCHAR(36)")
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    @OneToOne
    @JoinColumn(name = "discount_id", referencedColumnName = "id", nullable = false, unique = true, columnDefinition = "VARCHAR(36)")
    private Discount discount;

    @Column(name = "deleted_date", nullable = false)
    private LocalDateTime deletedDate = LocalDateTime.now();
}