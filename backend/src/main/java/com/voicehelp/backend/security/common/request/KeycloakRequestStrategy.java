package com.voicehelp.backend.security.common.request;

import org.springframework.http.HttpEntity;

import java.util.Map;
import java.util.Optional;

public interface KeycloakRequestStrategy<T> {

    Optional<T> doRequest(KeycloakRequest keycloakRequest);

    default HttpEntity<?> buildRequest(KeycloakRequest keycloakRequest) {

        return new HttpEntity<>(keycloakRequest.getParameters(), keycloakRequest.getHeaders());
    }
}
