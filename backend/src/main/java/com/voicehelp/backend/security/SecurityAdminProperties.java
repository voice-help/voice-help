package com.voicehelp.backend.security;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "vh.security.admin", ignoreInvalidFields = true)
@Data
public class SecurityAdminProperties {
    private String secret;
    private String clientId;
    private String tokenUrl;
    private String userUrl;
    private String resetPasswordUrl;
}
