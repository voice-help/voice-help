import 'package:flutter/material.dart';
import 'package:voicehelp/screen/home.screen.dart';
import 'package:voicehelp/screen/login.screen.dart';
import 'package:voicehelp/screen/register.screen.dart';
import 'package:voicehelp/service/user_service.dart' as userService;
import 'package:voicehelp/common/routes.dart' as routes;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Voice help',
    initialRoute: '/',
    routes: {
      routes.ROOT: (context) => MyApp(),
      routes.SIGN_IN: (context) => LoginScreen(),
      routes.SIGN_UP : (context) => RegisterScreen(),
      routes.HOME : (context) => HomeScreen(),
    },

  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder(
          future: userService.isSignIn(),
          builder: (context, snapShot) {
            if (snapShot.data == true) {
              return HomeScreen();
            }
            return LoginScreen(); // finally here should be some loading screen
          },
        ));
  }
}
