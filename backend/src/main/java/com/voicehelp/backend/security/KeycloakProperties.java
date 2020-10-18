package com.voicehelp.backend.security;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "vh.keycloak")
@Data
public class KeycloakProperties {

    private String authServerUrl;
    private String realm;
    private String resource;
    private String secret;

}
