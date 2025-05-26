package com.dotuandat.services;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.dotuandat.dtos.request.user.GuestCreateRequest;
import com.dotuandat.dtos.request.user.UserCreateRequest;
import com.dotuandat.dtos.request.user.UserSearchRequest;
import com.dotuandat.dtos.request.user.UserUpdateRequest;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.user.UserResponse;

public interface UserService {
    PageResponse<UserResponse> search(UserSearchRequest request, Pageable pageable);

    UserResponse create(UserCreateRequest request);

    UserResponse createGuest(GuestCreateRequest request);

    UserResponse update(String id, UserUpdateRequest request);

    void delete(List<String> ids);

    UserResponse getMyInfo();

    UserResponse getById(String id);
}
