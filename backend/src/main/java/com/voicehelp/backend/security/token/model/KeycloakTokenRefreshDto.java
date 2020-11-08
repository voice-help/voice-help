package com.voicehelp.backend.security.token.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class KeycloakTokenRefreshDto {
    @JsonProperty("refresh_token")
    private String refreshToken;

}
