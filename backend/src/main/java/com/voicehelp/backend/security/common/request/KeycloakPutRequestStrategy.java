package com.voicehelp.backend.security.common.request;

import com.voicehelp.backend.common.StringUtils;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;
import java.util.Map;
import java.util.Optional;

public class KeycloakPutRequestStrategy implements KeycloakRequestStrategy<Void> {

    private final Map<String, String> urlParameters;

    public KeycloakPutRequestStrategy() {
        this(Collections.emptyMap());
    }

    public KeycloakPutRequestStrategy(Map<String, String> urlParameters) {
        this.urlParameters = urlParameters;
    }

    @Override
    public Optional<Void> doRequest(KeycloakRequest keycloakRequest) {
        var restTemplate = new RestTemplate();
        var parametrizedURL = StringUtils.formatWithParams(keycloakRequest.getRequestURL(), urlParameters);
        restTemplate.put(parametrizedURL, buildRequest(keycloakRequest));
        return Optional.empty();
    }
}
