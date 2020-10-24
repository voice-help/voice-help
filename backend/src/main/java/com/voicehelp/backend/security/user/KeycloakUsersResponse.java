package com.voicehelp.backend.security.user;

import com.voicehelp.backend.security.token.UserDTO;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class KeycloakUsersResponse {

    private List<UserDTO> usersList;

    public KeycloakUsersResponse() {
        this.usersList = new ArrayList<>();
    }
}
