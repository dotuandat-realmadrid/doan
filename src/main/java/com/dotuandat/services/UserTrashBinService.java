package com.dotuandat.services;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.trash.UserTrashBinResponse;
import com.dotuandat.entities.User;
import com.dotuandat.entities.UserTrashBin;

public interface UserTrashBinService {

	PageResponse<UserTrashBinResponse> search(Pageable pageable);

	List<UserTrashBin> create(List<User> users);

	void restore(List<String> ids);

}
