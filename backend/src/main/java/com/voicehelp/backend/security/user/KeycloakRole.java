package com.voicehelp.backend.security.user;

public enum KeycloakRole {
    USER("user"),
    ADMIN("admin");

    private final String value;

    KeycloakRole(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
