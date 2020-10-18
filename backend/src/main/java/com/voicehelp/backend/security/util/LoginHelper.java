package com.voicehelp.backend.security.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.voicehelp.backend.security.KeycloakProperties;
import com.voicehelp.backend.security.KeycloakTokenResponse;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;

public class LoginHelper {

    private final KeycloakProperties properties;

    public LoginHelper(KeycloakProperties properties){
        this.properties = properties;
    }

    /**
     * @param json Json response
     * @return KeycloakTokenResponse
     * @throws JsonProcessingException exception
     */
    public  KeycloakTokenResponse getTokenResponse(String json) throws JsonProcessingException {
        var mapper = new ObjectMapper();
        return mapper.readValue(json, KeycloakTokenResponse.class);
    }

    public  HttpEntity<LinkedMultiValueMap<String, String>> generateTokenRequest(String username, String password) {
        var headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        var parameters = new LinkedMultiValueMap<String, String>();
        parameters.add("grant_type", "password");
        parameters.add("client_id", properties.getResource());
        parameters.add("client_secret", properties.getSecret());
        parameters.add("username", username);
        parameters.add("password", password);

        return new HttpEntity<>(parameters, headers);
    }

    public HttpEntity<LinkedMultiValueMap<String, String>> generateTokenRefreshRequest(String refreshToken) {
        var headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        var parameters = new LinkedMultiValueMap<String, String>();
        parameters.add("grant_type", "refresh_token");
        parameters.add("client_id", properties.getResource());
        parameters.add("client_secret", properties.getSecret());
        parameters.add("refresh_token", refreshToken);

        return new HttpEntity<>(parameters, headers);
    }
}
