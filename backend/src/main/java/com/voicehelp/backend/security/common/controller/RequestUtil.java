package com.voicehelp.backend.security.common.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.voicehelp.backend.common.function.RequestSupplier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.HttpClientErrorException;

public class RequestUtil {

    public static ResponseEntity<?> handleRequestException(RequestSupplier<ResponseEntity<?>> responseEntitySupplier) throws JsonProcessingException {

        try {
            return responseEntitySupplier.get();
        } catch (HttpClientErrorException exception) {
            HttpStatus statusCode = exception.getStatusCode();
            return new ResponseEntity<>(exception.getResponseBodyAsString(), statusCode);
        }
    }
}
