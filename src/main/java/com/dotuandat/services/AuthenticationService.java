package com.dotuandat.services;

import java.text.ParseException;

import com.dotuandat.dtos.request.auth.AuthenticationRequest;
import com.dotuandat.dtos.request.auth.IntrospectRequest;
import com.dotuandat.dtos.request.auth.LogoutRequest;
import com.dotuandat.dtos.request.auth.RefreshRequest;
import com.dotuandat.dtos.response.auth.AuthenticationResponse;
import com.dotuandat.dtos.response.auth.IntrospectResponse;
import com.dotuandat.dtos.response.auth.RefreshResponse;
import com.nimbusds.jose.JOSEException;

public interface AuthenticationService {

    AuthenticationResponse authenticate(AuthenticationRequest request);

    IntrospectResponse introspect(IntrospectRequest request) throws JOSEException, ParseException;
    
    void logout(LogoutRequest request) throws ParseException, JOSEException;

    RefreshResponse refreshToken(RefreshRequest request) throws ParseException, JOSEException;
}
