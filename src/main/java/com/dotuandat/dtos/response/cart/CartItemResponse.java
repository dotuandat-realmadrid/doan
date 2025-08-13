package com.dotuandat.dtos.response.cart;

import java.util.List;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CartItemResponse {
    String productId;
    String productCode;
    String productName;
    List<String> images;
    long price;
    Long discountPrice;
    int quantity;
}
