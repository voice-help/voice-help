package com.voicehelp.backend.security;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "vh.security")
@Data
public class SecurityProperties {
    private String tokenUrl;
}
