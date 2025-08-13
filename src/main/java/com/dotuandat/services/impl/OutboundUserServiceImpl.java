package com.dotuandat.services.impl;

import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Service;

import com.dotuandat.dtos.response.user.OutboundUserResponse;
import com.dotuandat.entities.Role;
import com.dotuandat.entities.User;
import com.dotuandat.repositories.RoleRepository;
import com.dotuandat.repositories.UserRepository;
import com.dotuandat.services.OutboundUserService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OutboundUserServiceImpl implements OutboundUserService {
    UserRepository userRepository;
    RoleRepository roleRepository;

    @Override
    public User onboardUser(OutboundUserResponse userInfo) {
        List<Role> roles = Collections.singletonList(roleRepository.findByCode("CUSTOMER"));
        return userRepository
                .findByUsername(userInfo.getEmail())
                .orElseGet(() -> userRepository.save(User.builder()
                        .username(userInfo.getEmail())
                        .fullName(userInfo.getName())
                        .isActive((byte) 1)
                        .roles(roles)
                        .build()));
    }
}
