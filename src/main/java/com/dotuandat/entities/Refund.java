package com.dotuandat.entities;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;

import com.dotuandat.enums.RefundStatus;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;
import lombok.experimental.SuperBuilder;

@Entity
@Table(name = "refund")
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Refund extends BaseEntity {

    @Column(name = "code", nullable = false)
    String code;

    @ManyToOne
    @JoinColumn(name = "user_id")
    User user;

    @ManyToOne
    @JoinColumn(name = "order_id")
    Order order;

    @Column(name = "refund_amount", nullable = false, precision = 10, scale = 2)
    @DecimalMin(value = "0.0", inclusive = false)
    BigDecimal refundAmount;

    @Column(name = "reason", length = 500)
    String reason;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    RefundStatus status;

    @Column(name = "transaction_date", nullable = false)
    @Builder.Default
    LocalDateTime transactionDate = LocalDateTime.now();

    @Column(name = "note", length = 1000)
    String note;
}
