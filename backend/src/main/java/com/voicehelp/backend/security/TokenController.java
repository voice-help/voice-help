package com.voicehelp.backend.security;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.voicehelp.backend.common.function.RequestSupplier;
import com.voicehelp.backend.security.util.LoginHelper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/api/v1/token")
public class TokenController {

    @Value(value = "${vh.security.token-url-pattern}")
    private String tokenUrl;

    private final LoginHelper loginHelper;

    public TokenController(LoginHelper loginHelper) {
        this.loginHelper = loginHelper;
    }

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<?> generateToken(@RequestParam("username") String username, @RequestParam("password") String password) throws JsonProcessingException {
        return handleRequestException(() -> {
            var restTemplate = new RestTemplate();
            var request = loginHelper.generateTokenRequest(username, password);
            var response = restTemplate.postForEntity(tokenUrl, request, String.class);
            KeycloakTokenResponse tokenResponse = loginHelper.getTokenResponse(response.getBody());
            return new ResponseEntity<>(tokenResponse, HttpStatus.ACCEPTED);
        });
    }

    @RequestMapping(value = "/refresh", method = RequestMethod.POST)
    public ResponseEntity<?> refreshToken(@RequestParam("refresh_token") String refreshToken) throws JsonProcessingException {

        return handleRequestException(() -> {
            var restTemplate = new RestTemplate();
            var request = loginHelper.generateTokenRefreshRequest(refreshToken);
            var response = restTemplate.postForEntity(tokenUrl, request, String.class);
            KeycloakTokenResponse tokenResponse = loginHelper.getTokenResponse(response.getBody());
            return new ResponseEntity<>(tokenResponse, HttpStatus.ACCEPTED);
        });
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
