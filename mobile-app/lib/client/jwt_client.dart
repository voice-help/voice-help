import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voicehelp/config.dart';

Future<TokenResponse> fetchToken(
    {AppConfig config, TokenRequest request}) async {
  return http
      .post(config.tokenUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: TokenRequest.toJson(request))
      .then((response) =>
      TokenResponse.fromJson(
          jsonDecode(response.body), response.statusCode));
}

Future<bool> validateAccessToken({AppConfig config, String accessToken}) async {
  return http.post(config.validateAccessTokenUrl, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $accessToken'
  }).then((response) => response.statusCode == 200 ? true : false);
}

Future<TokenResponse> refreshAccessToken(
    {AppConfig config, String refreshToken}) async {
  var response = await http.post(config.refreshTokenUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{config.refreshTokenKey: refreshToken}));
  var isBodyEmpty = response.body.isEmpty;
  if (!isBodyEmpty) {
    return TokenResponse.fromJson(
        jsonDecode(response.body), response.statusCode);
  }
  return TokenResponse(status: response.statusCode);
}

class TokenRequest {
  final String username;
  final String password;

  TokenRequest({this.username, this.password});

  static String toJson(TokenRequest tokenRequest) {
    return jsonEncode(<String, String>{
      'username': tokenRequest.username,
      'password': tokenRequest.password
    });
  }
}

class TokenResponse {
  final String accessToken;
  final String refreshToken;
  final int status;

  TokenResponse({this.accessToken, this.refreshToken, this.status});

  factory TokenResponse.fromJson(Map<String, dynamic> json, int status) {
    return TokenResponse(
      accessToken: json[JWTConstants.JSON_TOKEN_PROPERTY],
      refreshToken: json[JWTConstants.JSON_REFREST_TOKEN_PROPERTY],
      status: status,
    );
  }
}

class JWTConstants {
  static const String JSON_TOKEN_PROPERTY = 'access_token';
  static const String JSON_REFREST_TOKEN_PROPERTY = 'refresh_token';
}
