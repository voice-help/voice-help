package com.voicehelp.backend.security.common.request;

import org.springframework.http.HttpMethod;
import org.springframework.web.client.RestTemplate;

import java.util.Map;
import java.util.Optional;

public class KeycloakGetRequestStrategy<T> implements KeycloakRequestStrategy<T> {
    private final Class<T> responseClass;

    public KeycloakGetRequestStrategy(Class<T> responseClass) {
        this.responseClass = responseClass;
    }

    @Override
    public Optional<T> doRequest(KeycloakRequest keycloakRequest) {
        String requestUrl = buildRequestURL(keycloakRequest.getRequestURL(), keycloakRequest.getParameters());
        var restTemplate = new RestTemplate();
        var response =
                restTemplate.exchange(requestUrl, HttpMethod.GET, buildRequest(keycloakRequest), responseClass);

        return Optional.ofNullable(response.getBody());
    }

    private String buildRequestURL(String urlBase, Map<String, String> parameters) {
        StringBuilder urlBuilder = new StringBuilder(urlBase);
        urlBuilder.append("?");
        parameters.forEach((key, value) -> {
            urlBuilder.append(key)
                    .append("=")
                    .append(value)
                    .append("&");
        });
        return urlBuilder.toString();
    }
}
