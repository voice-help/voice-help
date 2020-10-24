package com.voicehelp.backend.security.user.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class UserDTO {

    @JsonProperty("id")
    private String id;
    @JsonProperty("username")
    private String userName;
    @JsonProperty("password")
    private String password;
    @JsonProperty("email")
    private String email;

    private UserDTO() {

    }

    @JsonCreator
    public UserDTO(@JsonProperty("id") String id,
                   @JsonProperty("username") String userName,
                   @JsonProperty("password") String password) {
        this.id = id;
        this.userName = userName;
        this.password = password;
    }


    public UserDTO createWith(String id) {
        return new UserDTO(id, this.getUserName(), this.getPassword());
    }
}
