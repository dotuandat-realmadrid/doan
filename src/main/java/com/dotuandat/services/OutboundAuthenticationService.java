package com.dotuandat.services;

import com.dotuandat.dtos.response.auth.AuthenticationResponse;

public interface OutboundAuthenticationService {
    AuthenticationResponse outboundAuthentication(String code);
}
