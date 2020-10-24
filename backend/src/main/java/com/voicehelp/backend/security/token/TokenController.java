package com.voicehelp.backend.security.token;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.voicehelp.backend.common.function.RequestSupplier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;

@RestController
@RequestMapping("/api/v1/token")
public class TokenController {


    private final KeycloakTokenService keycloakTokenService;

    public TokenController(KeycloakTokenService keycloakTokenService) {
        this.keycloakTokenService = keycloakTokenService;
    }

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<?> generateToken(@RequestParam("username") String username, @RequestParam("password") String password) throws JsonProcessingException {
        return handleRequestException(() -> new ResponseEntity<>(keycloakTokenService.generateToken(username, password), HttpStatus.OK));
    }

    @RequestMapping(value = "/refresh", method = RequestMethod.POST)
    public ResponseEntity<?> refreshToken(@RequestParam("refresh_token") String refreshToken) throws JsonProcessingException {

        return handleRequestException(() -> new ResponseEntity<>(keycloakTokenService.refreshToken(refreshToken), HttpStatus.ACCEPTED));
    }

    private ResponseEntity<?> handleRequestException(RequestSupplier<ResponseEntity<?>> responseEntitySupplier) throws JsonProcessingException {

        try {
            return responseEntitySupplier.get();
        } catch (HttpClientErrorException exception) {
            HttpStatus statusCode = exception.getStatusCode();
            return new ResponseEntity<>(exception.getResponseBodyAsString(), statusCode);
        }
    }


}
