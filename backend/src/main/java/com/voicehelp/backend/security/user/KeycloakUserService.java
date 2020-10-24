package com.voicehelp.backend.security.user;

import com.voicehelp.backend.security.KeycloakTokenResponse;
import com.voicehelp.backend.security.SecurityAdminProperties;
import com.voicehelp.backend.security.common.request.*;
import com.voicehelp.backend.security.token.UserDTO;
import org.apache.commons.codec.binary.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class KeycloakUserService {
    private final SecurityAdminProperties adminProperties;

    public KeycloakUserService(SecurityAdminProperties adminProperties) {
        this.adminProperties = adminProperties;
    }

    public UserDTO createUser(UserDTO userDTO) {
        var adminToken = getAdminToken();

        var newUserRequest =
                new KeycloakRequest.KeycloakRequestBuilder(adminProperties.getUserUrl(), MediaType.APPLICATION_JSON)
                        .bearerToken(adminToken.getAccessToken())
                        .parameter("username", userDTO.getUserName())
                        .parameter("email", userDTO.getEmail())
                        .parameter("enabled", "true")
                        .build();
        newUserRequest.doRequest(new KeycloakPostRequestStrategy<>(Void.class));

        String userID = getUserID(userDTO, adminToken);
        userDTO.setId(userID);
        changeUserPassword(userDTO, adminToken);
        return userDTO;
    }


    private void changeUserPassword(UserDTO userDTO, KeycloakTokenResponse adminToken) {

        var request =
                new KeycloakRequest.KeycloakRequestBuilder(adminProperties.getResetPasswordUrl(), MediaType.APPLICATION_JSON)
                        .bearerToken(adminToken.getAccessToken())
                        .parameter("type", "password")
                        .parameter("value", userDTO.getPassword())
                        .parameter("temporary", "false")
                        .build();
        request.doRequest(new KeycloakPutRequestStrategy(Map.of("userId", userDTO.getId())));

    }


    private String getUserID(UserDTO userDTO, KeycloakTokenResponse adminToken) {
        var user = getUserByUsername(userDTO.getUserName(), adminToken);
        var userId = user.getId();
        return userId;
    }

    private UserDTO getUserByUsername(String userName, KeycloakTokenResponse adminToken) {
        var request = new KeycloakRequest.KeycloakRequestBuilder(adminProperties.getUserUrl(), MediaType.APPLICATION_JSON)
                .bearerToken(adminToken.getAccessToken())
                .parameter("username", userName)
                .build();
        Optional<UserDTO[]> keycloakUsersResponse =
                request.doRequest(new KeycloakGetRequestStrategy<>(UserDTO[].class));

        UserDTO[] userResponse =
                keycloakUsersResponse.orElseThrow(() -> new RuntimeException("Cant retrive users response"));
        List<UserDTO> responseUsersList = List.of(userResponse);
        return responseUsersList.stream()
                .filter(responseUser -> {
                    String responseUserUserName = responseUser.getUserName();
                    return StringUtils.equals(responseUserUserName, userName);
                }).findFirst()
                .orElseThrow(() -> new RuntimeException("Cant find user with username"));
    }


    private KeycloakTokenResponse getAdminToken() {
        var request =
                new KeycloakRequest.KeycloakRequestBuilder(adminProperties.getTokenUrl(), MediaType.APPLICATION_FORM_URLENCODED)
                        .parameter("grant_type", "client_credentials")
                        .parameter("client_id", adminProperties.getClientId())
                        .parameter("client_secret", adminProperties.getSecret()).build();
        return request.doRequest(new KeycloakAdminTokenRequestStrategy<>(KeycloakTokenResponse.class))
                .orElseThrow(() -> new RuntimeException("Can not get admin token"));
    }

}
