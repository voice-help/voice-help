import 'package:flutter/material.dart';
import 'package:voicehelp/component/login_form.dart';
import 'package:voicehelp/screen/app_screen.dart';
import 'package:voicehelp/screen/register.screen.dart';
import 'package:voicehelp/component/passwordInput.dart';
import 'package:voicehelp/component/securityButton.dart';
import 'package:voicehelp/component/securityText.dart';
import 'package:voicehelp/component/securityInput.dart';
import 'package:voicehelp/service/user_service.dart' as userService;
import 'package:voicehelp/common/routes.dart' as routes;
import 'package:voicehelp/validator/not_empty_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginForm());
  }
}
