import 'package:flutter/material.dart';

class SecurityInput extends StatefulWidget {
  final TextEditingController _controller;
  final String _caption;
  final FormFieldValidator<String> _validator;

  SecurityInput(this._controller, this._caption,
      [this._validator]);

  @override
  _SecurityInputState createState() =>
      _SecurityInputState(_controller, _caption, this._validator);
}

class _SecurityInputState extends State<SecurityInput> {
  final TextEditingController _controller;
  final String _caption;
  final FormFieldValidator<String> _validator;

  _SecurityInputState(this._controller, this._caption, [this._validator]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          validator: _validator,
          controller: _controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              fillColor: Colors.lightBlueAccent,
              labelText: _caption,
              labelStyle: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              )),
        ),
      ),
    );
  }
}
