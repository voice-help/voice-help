package com.voicehelp.backend.security.user.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.voicehelp.backend.security.user.KeycloakRole;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


public class UserCreateDTO {

    @JsonProperty("username")
    private String userName;
    @JsonProperty("email")
    private String email;
    @JsonProperty("enabled")
    private boolean enabled;
    @JsonProperty("credentials")
    private List<UserCredentials> credentials;
    @JsonProperty("realmRoles")
    private List<String> roles;


    public UserCreateDTO() {

    }

    public UserCreateDTO(String userName, String email, boolean enabled, List<UserCredentials> credentials, List<String> roles) {
        this.userName = userName;
        this.email = email;
        this.enabled = enabled;
        this.credentials = credentials;
        this.roles = roles;
    }

    public static class Builder {
        private String userName;
        private String email;
        private boolean enabled;
        private UserCredentials credentials;
        private List<String> roles;

        public Builder(String userName) {
            this.userName = userName;
            this.enabled = true;
            this.credentials = new UserCredentials();
            this.roles = new ArrayList<>();
        }

        public Builder email(String email) {
            this.email = email;
            return this;
        }

        public Builder enabled(boolean enabled) {
            this.enabled = enabled;
            return this;
        }
        public Builder password(String password) {
            this.credentials.setType("password");
            this.credentials.setValue(password);
            return this;
        }

        public Builder role(KeycloakRole role) {
            roles.add(role.getValue());
            return this;
        }

        public UserCreateDTO build() {
            return new UserCreateDTO(userName, email, enabled, Collections.singletonList(credentials), roles);
        }

    }
}
