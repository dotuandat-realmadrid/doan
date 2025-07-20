package com.dotuandat.controllers;

import java.util.List;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dotuandat.dtos.response.ApiResponse;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.trash.ProductTrashBinResponse;
import com.dotuandat.services.ProductTrashBinService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;


@RestController
@RequestMapping("/products")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ProductTrashBinController {

	ProductTrashBinService productTrashBinService;
	
	@GetMapping("/trash")
	public ApiResponse<PageResponse<ProductTrashBinResponse>> search(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size
    ) {
		Sort sort = Sort.by(Sort.Direction.DESC, "deletedDate");

        Pageable pageable = PageRequest.of(page - 1, size, sort);

        return ApiResponse.<PageResponse<ProductTrashBinResponse>>builder()
                .result(productTrashBinService.search(pageable))
                .build();
	}
	
	@PutMapping("/restore/{ids}")
    public ApiResponse<Void> delete(@PathVariable List<String> ids) {
		productTrashBinService.restore(ids);
        return ApiResponse.<Void>builder()
                .message("Restored successfully")
                .build();
    }
	
}
