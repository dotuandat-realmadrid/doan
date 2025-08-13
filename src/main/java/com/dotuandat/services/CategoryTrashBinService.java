package com.dotuandat.services;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.trash.CategoryTrashBinResponse;
import com.dotuandat.entities.Category;
import com.dotuandat.entities.CategoryTrashBin;

public interface CategoryTrashBinService {

    PageResponse<CategoryTrashBinResponse> search(Pageable pageable);

    CategoryTrashBin create(Category categories);

    void restore(List<String> categoryIds);
}
