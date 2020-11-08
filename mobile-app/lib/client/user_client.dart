import 'dart:convert';

import 'package:voicehelp/config.dart';
import 'package:http/http.dart' as http;

Future<UserResponse> createUser(
    {CreateUserRequest request, AppConfig config}) async {
  return http
      .post(config.userUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: CreateUserRequest.toJson(request))
      .then((response) => UserResponse.fromJson(
          response.statusCode, jsonDecode(response.body)));
}

class UserResponse {
  final int _status;
  String _errorMessage;

  UserResponse(this._status, this._errorMessage);

  factory UserResponse.fromJson(int status, Map<String, dynamic> json) {
    return UserResponse(status, json['errorMessage']);
  }

  String get errorMessage => _errorMessage;

  int get status => _status;
}

class CreateUserRequest {
  final String _username;
  final String _email;
  final String _password;

  CreateUserRequest(this._username, this._email, this._password);

  static String toJson(CreateUserRequest request) {
    return jsonEncode(<String, String>{
      'username': request.username,
      'email': request.email,
      'password': request.password,
    });
  }

  String get password => _password;

  String get email => _email;

  String get username => _username;
}
