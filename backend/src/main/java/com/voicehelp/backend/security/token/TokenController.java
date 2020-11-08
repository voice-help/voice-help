package com.voicehelp.backend.security.token;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.voicehelp.backend.security.common.controller.RequestUtil;
import com.voicehelp.backend.security.token.model.KeycloakTokenRefreshDto;
import com.voicehelp.backend.security.token.model.UserTokenDto;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.security.RolesAllowed;

@RestController
@RequestMapping("/api/v1/token")
public class TokenController {


    private final KeycloakTokenService keycloakTokenService;

    public TokenController(KeycloakTokenService keycloakTokenService) {
        this.keycloakTokenService = keycloakTokenService;
    }

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<?> generateToken(@RequestBody UserTokenDto userDto) throws JsonProcessingException {
        return RequestUtil.handleRequestException(() ->
                new ResponseEntity<>(keycloakTokenService.generateToken(userDto.getUserName(), userDto.getPassword()), HttpStatus.OK));
    }

    @RequestMapping(value = "/refresh", method = RequestMethod.POST)
    public ResponseEntity<?> refreshToken(@RequestBody KeycloakTokenRefreshDto refreshToken) throws JsonProcessingException {

        return RequestUtil.handleRequestException(() ->
                new ResponseEntity<>(keycloakTokenService.refreshToken(refreshToken), HttpStatus.ACCEPTED));
    }

    @RequestMapping(value = "/validate", method = RequestMethod.POST)
    @RolesAllowed("user")
    public ResponseEntity<?> validateToken() {
        return new ResponseEntity<>(HttpStatus.OK);
    }


}
