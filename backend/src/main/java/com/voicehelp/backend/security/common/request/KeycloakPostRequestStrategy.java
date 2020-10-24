package com.voicehelp.backend.security.common.request;

import org.springframework.http.HttpEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.Optional;

public class KeycloakPostRequestStrategy<T> implements KeycloakRequestStrategy<T> {

    private final Class<T> responseClass;

    public KeycloakPostRequestStrategy(Class<T> responseClass) {
        this.responseClass = responseClass;
    }

    @Override
    public Optional<T> doRequest(KeycloakRequest keycloakRequest) {
        var restTemplate = new RestTemplate();
        var response = restTemplate.postForEntity(keycloakRequest.getRequestURL(),
                buildRequest(keycloakRequest), responseClass);
        return Optional.ofNullable(response.getBody());
    }
}
