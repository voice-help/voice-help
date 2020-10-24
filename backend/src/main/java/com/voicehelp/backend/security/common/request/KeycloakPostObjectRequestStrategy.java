package com.voicehelp.backend.security.common.request;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpEntity;
import org.springframework.web.client.RestTemplate;

import java.util.Optional;

public class KeycloakPostObjectRequestStrategy<OBJ, RES> implements KeycloakRequestStrategy<RES> {

    private final OBJ object;
    private final Class<RES> responseClass;

    public KeycloakPostObjectRequestStrategy(Class<RES> responseClass, OBJ object) {
        this.object = object;
        this.responseClass = responseClass;
    }

    @Override
    public Optional<RES> doRequest(KeycloakRequest keycloakRequest) {
        var restTemplate = new RestTemplate();
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            String s = objectMapper.writeValueAsString(object);
            var entity = new HttpEntity<>(s, keycloakRequest.getHeaders());
            var response = restTemplate.postForObject(keycloakRequest.getRequestURL(), entity, responseClass);
            return Optional.ofNullable(response);
        } catch (JsonProcessingException exception) {
            exception.printStackTrace();
        }
        return Optional.empty();
    }


}
