package com.voicehelp.backend.security.common.exception;


import org.springframework.http.HttpStatus;

public class RequestException extends RuntimeException {
    private final HttpStatus httpStatus;

    public RequestException(HttpStatus status) {
        this.httpStatus = status;
    }

    public RequestException(String message, HttpStatus status) {
        super(message);
        this.httpStatus = status;
    }
}
