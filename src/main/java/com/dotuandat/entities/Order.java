package com.dotuandat.entities;

import java.util.List;

import jakarta.persistence.*;

import com.dotuandat.enums.OrderStatus;
import com.dotuandat.enums.OrderType;
import com.dotuandat.enums.PaymentMethod;

import lombok.*;
import lombok.experimental.FieldDefaults;
import lombok.experimental.SuperBuilder;

@Entity
@Table(name = "`order`")
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Order extends BaseEntity {
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    User user;

    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    OrderStatus status;

    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    OrderType orderType;

    @Column(nullable = false)
    Long totalPrice;

    @Column(length = 50)
    @Enumerated(EnumType.STRING)
    PaymentMethod paymentMethod;

    String note;

    @ManyToOne
    @JoinColumn(name = "address_id")
    Address address;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    List<OrderDetail> orderDetails;
}
