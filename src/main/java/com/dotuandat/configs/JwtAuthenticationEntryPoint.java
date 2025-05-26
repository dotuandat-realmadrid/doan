package com.dotuandat.configs;

import com.dotuandat.dtos.response.ApiResponse;
import com.dotuandat.exceptions.ErrorCode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import java.io.IOException;

public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {
	
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response,
                         AuthenticationException authException) throws IOException {
    	String accept = request.getHeader("Accept");

    	if (accept == null || accept.contains("html") || accept.contains("*/*")) {
            // Nếu là trình duyệt (thường gửi Accept: text/html)
        	System.out.println("Accept header: " + accept);
            response.sendRedirect("/doan/login.html");
        } else {
	        ErrorCode errorCode = ErrorCode.UNAUTHENTICATED;
	
	        response.setStatus(errorCode.getStatusCode().value());
	        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
	
	        ApiResponse<?> apiResponse = ApiResponse.builder()
	                .code(errorCode.getCode())
	                .message(errorCode.getMessage())
	                .build();
	
	        ObjectMapper objectMapper = new ObjectMapper();
	
	        response.getWriter().write(objectMapper.writeValueAsString(apiResponse));
	        response.flushBuffer();
        }
    }
}
