import 'package:flutter/material.dart';

class SecurityText extends StatelessWidget {
  final String value;
  SecurityText(this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 60, left: 10),
      child: Text(
        value,
        style: TextStyle(
          color: Colors.white,
          fontSize: 38,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

