package com.voicehelp.backend.common.function;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.web.client.HttpClientErrorException;

@FunctionalInterface
public interface RequestSupplier<T> {

    T get() throws HttpClientErrorException, JsonProcessingException;
}
