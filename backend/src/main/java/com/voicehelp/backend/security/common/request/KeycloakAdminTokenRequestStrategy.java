package com.voicehelp.backend.security.common.request;

import org.springframework.http.HttpEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.Map;
import java.util.Optional;

public class KeycloakAdminTokenRequestStrategy<T> implements KeycloakRequestStrategy<T> {

    private final Class<T> responseClass;

    public KeycloakAdminTokenRequestStrategy(Class<T> responseClass) {
        this.responseClass = responseClass;
    }

    @Override
    public Optional<T> doRequest(KeycloakRequest keycloakRequest) {
        var restTemplate = new RestTemplate();
        var response = restTemplate.postForEntity(keycloakRequest.getRequestURL(),
                buildRequest(keycloakRequest), responseClass);
        return Optional.ofNullable(response.getBody());
    }

    @Override
    public HttpEntity<MultiValueMap<String, String>> buildRequest(KeycloakRequest keycloakRequest) {
        var requestParameters = keycloakRequest.getParameters();
        var multiValueMapRequestParameters = new LinkedMultiValueMap<String, String>();
        requestParameters.forEach((key, value) -> multiValueMapRequestParameters.add(key, value));

        return new HttpEntity<>(multiValueMapRequestParameters, keycloakRequest.getHeaders());
    }
}
