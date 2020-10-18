package com.voicehelp.backend.security;

import com.voicehelp.backend.security.util.LoginHelper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SecurityConfig {

    @Bean
    public LoginHelper getLoginHelper(KeycloakProperties properties) {
        return new LoginHelper(properties);
    }
}
