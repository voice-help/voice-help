import 'package:flutter/material.dart';

class SecurityButton extends StatefulWidget {
  final Function _buttonPressedCallback;
  final String _caption;

  SecurityButton(this._buttonPressedCallback, this._caption);

  @override
  _SecurityButtonState createState() =>
      _SecurityButtonState(_buttonPressedCallback, _caption);
}

class _SecurityButtonState extends State<SecurityButton> {
  final Function _buttonPressedCallback;
  final String _caption;

  _SecurityButtonState(this._buttonPressedCallback, this._caption);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300],
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: Offset(
                5.0,
                5.0,
              ),
            ),
          ],
          color: Colors.white70,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
          onPressed: _buttonPressedCallback,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _caption,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
