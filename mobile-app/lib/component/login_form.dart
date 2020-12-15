import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voicehelp/component/passwordInput.dart';
import 'package:voicehelp/component/securityButton.dart';
import 'package:voicehelp/component/securityInput.dart';
import 'package:voicehelp/component/securityText.dart';
import 'package:voicehelp/screen/app_screen.dart';
import 'package:voicehelp/screen/register.screen.dart';
import 'package:voicehelp/validator/not_empty_validator.dart';
import 'package:voicehelp/service/user_service.dart' as userService;
import 'package:voicehelp/common/routes.dart' as routes;



class LoginForm extends StatelessWidget {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AppScreenContainer(
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SecurityText('Sign In'),
            SecurityInput(_usernameController, 'Username',
                (value) => NotEmptyValidator.validate(value)),
            PasswordInput(_passwordController, 'Password',
                (value) => NotEmptyValidator.validate(value)),
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SecurityButton(
                      () => onSignInButtonPressed(context), 'Sign In'),
                  SecurityButton(
                      () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          ),
                      'Sign Up'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSignInButtonPressed(BuildContext context) async {
    var username = _usernameController.text;
    var password = _passwordController.text;

    if(!_formKey.currentState.validate()){
      return;
    }
    var loginResponse =
    await userService.signIn(username: username, password: password);
    if (loginResponse.successfully) {
      Navigator.pushNamedAndRemoveUntil(context, routes.MAIN, (route) => false);
    } else {
      var failureSnackBar = buildSnackBar(loginResponse.failureMessage);
      Scaffold.of(context).showSnackBar(failureSnackBar);
    }
  }

  SnackBar buildSnackBar(String text) => SnackBar(
    content: Text(text),
  );
}
