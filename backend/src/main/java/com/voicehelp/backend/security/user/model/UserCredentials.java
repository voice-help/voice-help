package com.voicehelp.backend.security.user.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class UserCredentials {
    @JsonProperty("type")
    private String type;
    @JsonProperty("value")
    private String value;
}
