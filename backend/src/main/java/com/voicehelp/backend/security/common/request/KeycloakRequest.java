package com.voicehelp.backend.security.common.request;


import lombok.Getter;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Getter
public class KeycloakRequest {

    private final String requestURL;
    private final HttpHeaders headers;
    private final Map<String, String> parameters;

    public KeycloakRequest(String requestURL, HttpHeaders headers, Map<String, String> parameters) {
        this.requestURL = requestURL;
        this.parameters = parameters;
        this.headers = headers;
    }

    public <RESPONSE_TYPE> Optional<RESPONSE_TYPE> doRequest(KeycloakRequestStrategy<RESPONSE_TYPE> requestStrategy) {

        return requestStrategy.doRequest(this);
    }


    public static class KeycloakRequestBuilder {
        private final String requestURL;
        private final MediaType contentType;
        private HttpHeaders headers;
        private Map<String, String> parameters;

        public KeycloakRequestBuilder(String requestURL, MediaType contentType) {
            this.requestURL = requestURL;
            this.contentType = contentType;
            headers = new HttpHeaders();
            parameters = new HashMap<>();
        }

        public KeycloakRequestBuilder bearerToken(String token) {
            headers.setBearerAuth(token);
            return this;
        }

        public KeycloakRequestBuilder parameter(String key, String value) {
            parameters.put(key, value);
            return this;
        }

        public KeycloakRequest build() {
            headers.setContentType(contentType);
            return new KeycloakRequest(requestURL, headers, parameters);
        }

    }

}
