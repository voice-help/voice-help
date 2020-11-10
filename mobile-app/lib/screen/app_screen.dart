import 'package:flutter/material.dart';

class AppScreenContainer extends StatelessWidget {
  final Widget child;

  AppScreenContainer({this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blueGrey, Colors.lightBlueAccent],
        ),
      ),
      child: this.child,
    );
  }
}
