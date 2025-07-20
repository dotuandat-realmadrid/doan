package com.dotuandat.controllers;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dotuandat.dtos.response.ApiResponse;
import com.dotuandat.dtos.response.trash.DiscountTrashBinResponse;
import com.dotuandat.services.DiscountTrashBinService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RestController
@RequestMapping("/discounts")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class DiscountTrashBinController {

	DiscountTrashBinService discountTrashBinService;
	
	@GetMapping("/trash")
	public ApiResponse<List<DiscountTrashBinResponse>> findAll() {
		return ApiResponse.<List<DiscountTrashBinResponse>>builder()
				.result(discountTrashBinService.findAll())
				.build();
	}
	
	@PutMapping("/restore/{ids}")
    public ApiResponse<Void> delete(@PathVariable List<String> ids) {
		discountTrashBinService.restore(ids);
        return ApiResponse.<Void>builder()
                .message("Restored successfully")
                .build();
	}
}
