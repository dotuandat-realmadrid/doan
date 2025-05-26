package com.dotuandat.services;

import java.text.ParseException;

import com.dotuandat.entities.User;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jwt.SignedJWT;

public interface TokenService {

    String generateToken(User user);

    public SignedJWT verifyToken(String token, boolean isRefresh) throws ParseException, JOSEException;
}
