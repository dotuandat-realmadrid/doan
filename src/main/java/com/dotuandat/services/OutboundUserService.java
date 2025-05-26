package com.dotuandat.services;

import com.dotuandat.dtos.response.user.OutboundUserResponse;
import com.dotuandat.entities.User;

public interface OutboundUserService {
    User onboardUser(OutboundUserResponse userInfo);
}
