package com.voicehelp.backend.security.token.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class UserTokenDto {
    @JsonProperty("username")
    private String userName;
    @JsonProperty("password")
    private String password;

    public UserTokenDto(){

    }

    public UserTokenDto(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }
}
