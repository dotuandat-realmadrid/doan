package com.dotuandat.configs;

import java.io.IOException;

import org.springframework.http.MediaType;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import com.dotuandat.dtos.response.ApiResponse;
import com.dotuandat.exceptions.ErrorCode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CustomAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response,
                       AccessDeniedException accessDeniedException) throws IOException {

        String accept = request.getHeader("Accept");

        if (accept != null && accept.contains("text/html")) {
            response.sendRedirect("home.html");
        } else {
            ErrorCode errorCode = ErrorCode.FORBIDDEN;

            response.setStatus(errorCode.getStatusCode().value());
            response.setContentType(MediaType.APPLICATION_JSON_VALUE);

            ApiResponse<?> apiResponse = ApiResponse.builder()
                    .code(errorCode.getCode())
                    .message("Bạn không có quyền truy cập tài nguyên này")
                    .build();

            ObjectMapper objectMapper = new ObjectMapper();
            response.getWriter().write(objectMapper.writeValueAsString(apiResponse));
            response.flushBuffer();
        }
    }
}
