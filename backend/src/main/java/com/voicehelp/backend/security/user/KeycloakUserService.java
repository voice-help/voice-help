package com.voicehelp.backend.security.user;

import com.voicehelp.backend.security.KeycloakTokenResponse;
import com.voicehelp.backend.security.SecurityAdminProperties;
import com.voicehelp.backend.security.common.exception.RequestException;
import com.voicehelp.backend.security.common.request.KeycloakAdminTokenRequestStrategy;
import com.voicehelp.backend.security.common.request.KeycloakPostObjectRequestStrategy;
import com.voicehelp.backend.security.common.request.KeycloakRequest;
import com.voicehelp.backend.security.user.model.UserCreateDTO;
import com.voicehelp.backend.security.user.model.UserDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

@Service
public class KeycloakUserService {
    private final SecurityAdminProperties adminProperties;

    public KeycloakUserService(SecurityAdminProperties adminProperties) {
        this.adminProperties = adminProperties;
    }

    public UserDTO createUser(UserDTO userDTO) {
        var adminToken = getAdminToken();
        var createUserDto = new UserCreateDTO.Builder(userDTO.getUserName())
                .email(userDTO.getEmail())
                .role(KeycloakRole.USER)
                .password(userDTO.getPassword())
                .build();
        var newUserRequest =
                new KeycloakRequest.KeycloakRequestBuilder(adminProperties.getUserUrl(), MediaType.APPLICATION_JSON)
                        .bearerToken(adminToken.getAccessToken())
                        .build();
        newUserRequest.doRequest(new KeycloakPostObjectRequestStrategy<>(Void.class, createUserDto));
        return userDTO;
    }

    private KeycloakTokenResponse getAdminToken() {
        var request =
                new KeycloakRequest.KeycloakRequestBuilder(adminProperties.getTokenUrl(), MediaType.APPLICATION_FORM_URLENCODED)
                        .parameter("grant_type", "client_credentials")
                        .parameter("client_id", adminProperties.getClientId())
                        .parameter("client_secret", adminProperties.getSecret()).build();
        return request.doRequest(new KeycloakAdminTokenRequestStrategy<>(KeycloakTokenResponse.class))
                .orElseThrow(() -> new RequestException("Internal error occured", HttpStatus.INTERNAL_SERVER_ERROR));
    }
}
