import 'package:flutter/material.dart';
import 'package:voicehelp/view/home_view.dart';
import 'package:voicehelp/view/record_view.dart';
import 'package:voicehelp/view/user_view.dart';

final List<Destination> destinations = [
  Destination('Home', Icons.home, HomeView()),
  Destination('Record', Icons.keyboard_voice, RecordView()),
  Destination('User', Icons.person, UserView())
];

class Destination {
  const Destination(this._label, this._icon, this._widget);

  final String _label;
  final IconData _icon;
  final Widget _widget;

  String get label => _label;

  IconData get icon => _icon;
}

class DestinationView extends StatefulWidget {
  const DestinationView({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() =>
      _DestinationViewState(destination._widget);
}

class _DestinationViewState extends State<DestinationView> {
  final Widget _body;

  _DestinationViewState(this._body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body);
  }
}
