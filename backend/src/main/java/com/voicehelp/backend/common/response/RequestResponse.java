package com.voicehelp.backend.common.response;

import org.springframework.http.HttpStatus;

public enum RequestResponse {
    OK(HttpStatus.OK),
    WRONG_PARAMETERS(HttpStatus.BAD_REQUEST, "Wrong request parameters");
    private final HttpStatus httpStatus;
    private String message;

    RequestResponse(HttpStatus httpStatus){
        this.httpStatus = httpStatus;
    }

    RequestResponse(HttpStatus httpStatus, String message) {
        this.httpStatus = httpStatus;
        this.message = message;
    }

    public HttpStatus getHttpStatus() {
        return httpStatus;
    }

    public String getMessage() {
        return message;
    }
}
