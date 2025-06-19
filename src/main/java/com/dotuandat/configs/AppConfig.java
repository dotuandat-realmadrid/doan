package com.dotuandat.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class AppConfig {

    @Bean
    public WebClient webClient() {
        return WebClient.builder()
                .baseUrl("") // Có thể để trống, URL sẽ được chỉ định khi gọi
                .build();
    }
}