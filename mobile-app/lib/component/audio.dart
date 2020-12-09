import 'package:flutter/material.dart';

class RecordButton extends StatelessWidget {
  final Function _onPressed;
  final bool _recording;

  RecordButton(this._onPressed, this._recording);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => _onPressed(),
      constraints: BoxConstraints(minHeight: 150, minWidth: 150),
      elevation: 2.0,
      fillColor: Colors.red,
      child: Container(
        child: _recording ? Icon(Icons.stop) : Icon(Icons.mic),
      ),
      shape: CircleBorder(),
    );
  }
}

class RecordTimer extends StatelessWidget{
  final int _remainingDuration;


  RecordTimer(this._remainingDuration);

  @override
  Widget build(BuildContext context) {
    final String minutes = _formatNumber(_remainingDuration ~/ 60);
    final String seconds = _formatNumber(_remainingDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: TextStyle(color: Colors.black, fontSize: 24),
    );
  }


  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

}
