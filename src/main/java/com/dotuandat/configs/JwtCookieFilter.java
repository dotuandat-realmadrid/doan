package com.dotuandat.configs;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.dotuandat.dtos.request.auth.LogoutRequest;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletInputStream;
import jakarta.servlet.ReadListener;

@Component
public class JwtCookieFilter extends OncePerRequestFilter {

    private static final String TOKEN_COOKIE_NAME = "token";
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        // Log để debug
        System.out.println("Processing request: " + request.getRequestURI() + " Method: " + request.getMethod());

        // Kiểm tra nếu request tới endpoint /doan/auth/logout
        if ("/doan/auth/logout".equals(request.getRequestURI()) && "POST".equalsIgnoreCase(request.getMethod())) {
            // Kiểm tra xem body có rỗng không
            boolean isBodyEmpty = isRequestBodyEmpty(request);

            System.out.println("Is body empty for /doan/auth/logout: " + isBodyEmpty);

            if (isBodyEmpty) {
                // Lấy token từ cookie
                String token = getTokenFromCookies(request.getCookies());

                if (token != null && !token.isEmpty()) {
                    // Tạo body JSON cho LogoutRequest
                    LogoutRequest logoutRequest = LogoutRequest.builder().token(token).build();
                    String jsonBody = objectMapper.writeValueAsString(logoutRequest);

                    // Log để kiểm tra body đã tạo
                    System.out.println("Generated body for logout: " + jsonBody);

                    // Wrap request để override body
                    request = new HttpServletRequestWrapper(request) {
                        @Override
                        public ServletInputStream getInputStream() throws IOException {
                            byte[] jsonBytes = jsonBody.getBytes(StandardCharsets.UTF_8);
                            ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(jsonBytes);
                            return new ServletInputStream() {
                                @Override
                                public boolean isFinished() {
                                    return byteArrayInputStream.available() == 0;
                                }

                                @Override
                                public boolean isReady() {
                                    return true;
                                }

                                @Override
                                public void setReadListener(ReadListener readListener) {
                                    // Không cần triển khai
                                }

                                @Override
                                public int read() throws IOException {
                                    return byteArrayInputStream.read();
                                }
                            };
                        }

                        @Override
                        public int getContentLength() {
                            return jsonBody.getBytes(StandardCharsets.UTF_8).length;
                        }

                        @Override
                        public long getContentLengthLong() {
                            return getContentLength();
                        }

                        @Override
                        public String getContentType() {
                            return "application/json";
                        }
                    };
                } else {
                    System.out.println("No valid token found in cookie for /doan/auth/logout");
                }
            } else {
                System.out.println("Body is not empty, skipping auto-generation");
            }
        }

        // Tiếp tục xử lý Authorization header
        Cookie[] cookies = request.getCookies();
        if (cookies != null && request.getHeader("Authorization") == null) {
            for (Cookie cookie : cookies) {
                if (TOKEN_COOKIE_NAME.equals(cookie.getName()) && cookie.getValue() != null && !cookie.getValue().isEmpty()) {
                    System.out.println("Cookie: " + cookie.getName() + "=" + cookie.getValue());
                    final String token = cookie.getValue();
                    request = new HttpServletRequestWrapper(request) {
                        @Override
                        public String getHeader(String name) {
                            if ("Authorization".equalsIgnoreCase(name)) {
                                return "Bearer " + token;
                            }
                            return super.getHeader(name);
                        }
                    };
                    break;
                }
            }
        }

        filterChain.doFilter(request, response);
    }

    // Hàm kiểm tra xem body có rỗng không
    private boolean isRequestBodyEmpty(HttpServletRequest request) throws IOException {
        try {
            int firstByte = request.getInputStream().read();
            return firstByte == -1; // -1 nếu body rỗng
        } catch (IOException e) {
            return true; // Nếu có lỗi khi đọc body, giả định body rỗng
        }
    }

    // Hàm lấy token từ cookies
    private String getTokenFromCookies(Cookie[] cookies) {
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (TOKEN_COOKIE_NAME.equals(cookie.getName()) && cookie.getValue() != null && !cookie.getValue().isEmpty()) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}