package com.dotuandat.services;

import java.util.List;

import com.dotuandat.dtos.request.product.DiscountProductRequest;
import com.dotuandat.entities.Discount;

public interface DiscountService {
    List<Discount> getAll();

    Discount create(Discount discount);

    Discount update(String id, Discount request);

    Discount addDiscountProducts(String id, DiscountProductRequest request);

    void delete(String id);
}