import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:voicehelp/component/passwordInput.dart';
import 'package:voicehelp/component/securityButton.dart';
import 'package:voicehelp/component/securityInput.dart';
import 'package:voicehelp/component/securityText.dart';
import 'package:voicehelp/screen/login.screen.dart';
import 'package:voicehelp/validator/confirm_password_validator.dart';
import 'package:voicehelp/validator/password_validator.dart';
import 'package:voicehelp/validator/username_validator.dart';
import 'package:voicehelp/service/user_service.dart' as userService;
import 'package:voicehelp/common/routes.dart' as routes;


class RegisterScreen extends StatefulWidget {


  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blueGrey, Colors.lightBlueAccent],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SecurityText('Sign Up'),
              SecurityInput(_usernameController, 'Username',
                  (String username) => UsernameValidator.validate(username)),
              SecurityInput(_emailController, 'Email', (String email) {
                if (email.isEmpty) {
                  return 'Required';
                }
                if (!EmailValidator.validate(email)) {
                  return "Invalid email";
                }
                return null;
              }),
              PasswordInput(_passwordController, 'Password',
                  (String password) => PasswordValidator.validate(password)),
              PasswordInput(
                  _confirmPasswordController,
                  'Confirm password',
                  (String confirmPassword) => ConfirmPasswordValidator.validate(
                      confirmPassword, _passwordController.text)),
              Container(
                padding: EdgeInsets.only(top: 50),
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecurityButton(
                        () => {
                              if (_formKey.currentState.validate())
                                {
                                  _onSignUpButtonPressed(context),
                                }
                            },
                        'Sign Up'),
                    SecurityButton(
                        () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen())),
                        'Sign In'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUpButtonPressed(BuildContext context) {
    var _username = _usernameController.text;
    var _email = _emailController.text;
    var _password = _passwordController.text;
    var signUpResponse = userService.signUp(
        username: _username, email: _email, password: _password);
    signUpResponse.then((response) => {
          if (response.successfully)
            {
              Navigator.pushNamedAndRemoveUntil(context, routes.SIGN_IN, (route) => false)
            }
        });
  }
}
