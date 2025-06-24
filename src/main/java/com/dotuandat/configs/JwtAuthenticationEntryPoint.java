//package com.dotuandat.configs;
//
//import com.dotuandat.dtos.response.ApiResponse;
//import com.dotuandat.exceptions.ErrorCode;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.springframework.http.MediaType;
//import org.springframework.security.core.AuthenticationException;
//import org.springframework.security.web.AuthenticationEntryPoint;
//
//import java.io.IOException;
//
//public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {
//    @Override
//    public void commence(HttpServletRequest request, HttpServletResponse response,
//                         AuthenticationException authException) throws IOException {
//        ErrorCode errorCode = ErrorCode.UNAUTHENTICATED;
//
//        response.setStatus(errorCode.getStatusCode().value());
//        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
//
//        ApiResponse<?> apiResponse = ApiResponse.builder()
//                .code(errorCode.getCode())
//                .message(errorCode.getMessage())
//                .build();
//
//        ObjectMapper objectMapper = new ObjectMapper();
//
//        response.getWriter().write(objectMapper.writeValueAsString(apiResponse));
//        response.flushBuffer();
//    }
//}

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
import java.util.Set;
import java.util.HashSet;
import java.util.Arrays;

public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private static final String LOGIN_URL = "/doan/login.html";
    
    // Chỉ dùng /doan/* làm API prefix
    private static final String API_PREFIX = "/doan/";
    
    // Các endpoints KHÔNG phải API (cần redirect)
    private static final Set<String> NON_API_PATHS = new HashSet<>(Arrays.asList(
        "/doan/login.html",
        "/doan/register.html", 
        "/doan/index.html"
    ));
    
    // Các thư mục static files
    private static final Set<String> STATIC_DIRECTORIES = new HashSet<>(Arrays.asList(
        "/doan/css/",
        "/doan/js/", 
        "/doan/images/",
        "/doan/static/",
        "/doan/assets/"
    ));
    
    // File extensions không phải API
    private static final Set<String> STATIC_EXTENSIONS = new HashSet<>(Arrays.asList(
        ".html", ".htm", ".css", ".js", ".png", ".jpg", ".jpeg", 
        ".gif", ".ico", ".svg", ".woff", ".woff2", ".ttf", ".eot"
    ));
    
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response,
                        AuthenticationException authException) throws IOException {

        String requestURI = request.getRequestURI();
        
        System.out.println("=== AUTH ENTRY POINT ===");
        System.out.println("Request URI: " + requestURI);
        System.out.println("Is API: " + isApiRequest(requestURI));
        
        if (isApiRequest(requestURI)) {
            sendJsonResponse(response);
        } else {
            redirectToLogin(response);
        }
    }

    /**
     * Kiểm tra có phải API request không với /doan/* logic
     */
    private boolean isApiRequest(String requestURI) {
        
        // Nếu không bắt đầu bằng /doan/ thì không phải API của chúng ta
        if (requestURI == null || !requestURI.startsWith(API_PREFIX)) {
            return false;
        }
        
        // Check explicit NON-API paths
        if (NON_API_PATHS.contains(requestURI)) {
            return false;
        }
        
        // Check static directories
        for (String staticDir : STATIC_DIRECTORIES) {
            if (requestURI.startsWith(staticDir)) {
                return false;
            }
        }
        
        // Check file extensions
        String lowerURI = requestURI.toLowerCase();
        for (String ext : STATIC_EXTENSIONS) {
            if (lowerURI.endsWith(ext)) {
                return false;
            }
        }
        
        // Nếu không thuộc các trường hợp trên thì coi là API
        return true;
    }

    private void sendJsonResponse(HttpServletResponse response) throws IOException {
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

    private void redirectToLogin(HttpServletResponse response) throws IOException {
        System.out.println("Redirecting to: " + LOGIN_URL);
        response.sendRedirect(LOGIN_URL);
    }
}