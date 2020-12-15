import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voicehelp/screen/app_screen.dart';
import 'package:voicehelp/screen/login.screen.dart';
import 'package:voicehelp/service/user_service.dart';

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;

    return AppScreenContainer(
      child: Container(
        alignment: Alignment.center,
        padding:  EdgeInsets.only(left: _screenWidth / 4, right: _screenWidth / 4, top: _screenHeight / 4, bottom: _screenHeight / 4 ),
        child: Column(
          children: [
            MaterialButton(
                onPressed: () => {
                  logout(),
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()))
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
