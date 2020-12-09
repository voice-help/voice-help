package com.voicehelp.backend.record.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND, reason = "Record not found")
public class RecordNotFoundException extends RuntimeException {
}
