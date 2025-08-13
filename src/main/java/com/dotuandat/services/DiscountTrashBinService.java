package com.dotuandat.services;

import java.util.List;

import com.dotuandat.dtos.response.trash.DiscountTrashBinResponse;
import com.dotuandat.entities.Discount;
import com.dotuandat.entities.DiscountTrashBin;

public interface DiscountTrashBinService {

    List<DiscountTrashBinResponse> findAll();

    DiscountTrashBin create(Discount discount);

    void restore(List<String> trashBinIds);
}
