package com.voicehelp.backend.security.user;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.voicehelp.backend.security.common.controller.RequestUtil;
import com.voicehelp.backend.security.user.model.UserDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/user")
public class UserController {

    private final KeycloakUserService userService;

    public UserController(KeycloakUserService userService) {
        this.userService = userService;
    }

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<?> createUser(@RequestBody UserDTO userDTO) throws JsonProcessingException {
        return RequestUtil.handleRequestException(() -> new ResponseEntity<>(userService.createUser(userDTO), HttpStatus.OK));
    }
}
