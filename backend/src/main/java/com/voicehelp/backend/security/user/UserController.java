package com.voicehelp.backend.security.user;

import com.voicehelp.backend.security.token.UserDTO;
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
    public ResponseEntity<UserDTO> createUser(@RequestBody UserDTO userDTO) {
        var createdUserDTO = userService.createUser(userDTO);
        return new ResponseEntity<>(createdUserDTO, HttpStatus.OK);
    }
}
