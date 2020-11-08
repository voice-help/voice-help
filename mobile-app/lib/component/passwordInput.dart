import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController _controller;
  final String _caption;
  final FormFieldValidator<String> _validator;
  PasswordInput(this._controller, this._caption, [this._validator]);

  @override
  State createState() => _PasswordInputState(_controller, _caption, this._validator);
}

class _PasswordInputState extends State<PasswordInput> {
  final TextEditingController _controller;
  final String _caption;
  final FormFieldValidator<String> _validator;

  _PasswordInputState(this._controller, this._caption, [this._validator]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50, right: 50, left: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: _controller,
          validator: _validator,
          textInputAction: TextInputAction.next,
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            labelText: _caption,
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
