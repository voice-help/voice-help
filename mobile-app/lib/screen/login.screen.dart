import 'package:flutter/material.dart';
import 'package:voicehelp/screen/app_screen.dart';
import 'package:voicehelp/screen/register.screen.dart';
import 'package:voicehelp/component/passwordInput.dart';
import 'package:voicehelp/component/securityButton.dart';
import 'package:voicehelp/component/securityText.dart';
import 'package:voicehelp/component/securityInput.dart';
import 'package:voicehelp/service/user_service.dart' as userService;
import 'package:voicehelp/common/routes.dart' as routes;

class LoginScreen extends StatefulWidget {


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenContainer(
        child: ListView(
          children: <Widget>[
            SecurityText('Sign In'),
            SecurityInput(_usernameController, 'Username'),
            PasswordInput(_passwordController, 'Password'),
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

    var loginResponse =
        await userService.signIn(username: username, password: password);
    if (loginResponse.successfully) {
        Navigator.pushNamedAndRemoveUntil(context, routes.MAIN, (route) => false);
    }
  }
}
