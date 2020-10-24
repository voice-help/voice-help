package com.voicehelp.backend.security.token;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.voicehelp.backend.security.KeycloakProperties;
import com.voicehelp.backend.security.KeycloakTokenResponse;
import com.voicehelp.backend.security.SecurityProperties;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class KeycloakTokenService {

    private final KeycloakProperties properties;
    private final SecurityProperties securityProperties;

    public KeycloakTokenService(KeycloakProperties properties, SecurityProperties securityProperties) {
        this.properties = properties;
        this.securityProperties = securityProperties;
    }

    public KeycloakTokenResponse refreshToken(String refreshToken) throws JsonProcessingException {
        var restTemplate = new RestTemplate();
        var request = generateTokenRefreshRequest(refreshToken);
        var response = restTemplate.postForEntity(securityProperties.getTokenUrl(), request, String.class);
        KeycloakTokenResponse tokenResponse = getTokenResponse(response.getBody());
        return tokenResponse;
    }

    public KeycloakTokenResponse generateToken(String userName, String password) throws JsonProcessingException {
        var restTemplate = new RestTemplate();
        var request = generateTokenRequest(userName, password);
        var response = restTemplate.postForEntity(securityProperties.getTokenUrl(), request, String.class);
        KeycloakTokenResponse tokenResponse = getTokenResponse(response.getBody());
        return tokenResponse;
    }

    private HttpEntity<LinkedMultiValueMap<String, String>> generateTokenRequest(String username, String password) {
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

    private HttpEntity<LinkedMultiValueMap<String, String>> generateTokenRefreshRequest(String refreshToken) {
        var headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        var parameters = new LinkedMultiValueMap<String, String>();
        parameters.add("grant_type", "refresh_token");
        parameters.add("client_id", properties.getResource());
        parameters.add("client_secret", properties.getSecret());
        parameters.add("refresh_token", refreshToken);

        return new HttpEntity<>(parameters, headers);
    }

    /**
     * @param json Json response
     * @return KeycloakTokenResponse
     * @throws JsonProcessingException exception
     */
    private KeycloakTokenResponse getTokenResponse(String json) throws JsonProcessingException {
        var mapper = new ObjectMapper();
        return mapper.readValue(json, KeycloakTokenResponse.class);
    }
}
