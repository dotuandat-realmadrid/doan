package com.dotuandat.services;

import com.dotuandat.dtos.request.password.ChangePasswordRequest;

public interface PasswordService {
    void changePassword(ChangePasswordRequest request);

    void setPassword(String password);

    void resetPassword(String id);

    Object forgotPassword(Object object);
}