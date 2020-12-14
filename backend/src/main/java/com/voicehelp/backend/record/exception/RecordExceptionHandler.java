package com.voicehelp.backend.record.exception;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

public class RecordExceptionHandler extends ResponseEntityExceptionHandler {

    @ExceptionHandler(value = RecordNotFoundException.class)
    protected ResponseEntity<?> handleRecordNotFoundException(RecordNotFoundException ex, WebRequest webRequest){
        return handleExceptionInternal(ex, "Record not found", new HttpHeaders(), HttpStatus.NOT_FOUND, webRequest);
    }
}
