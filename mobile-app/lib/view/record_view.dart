import 'dart:async';

import 'package:flutter/material.dart';
import 'package:voicehelp/component/record_button.dart';
import 'package:voicehelp/component/record_dialog.dart';
import 'package:voicehelp/controller/sound_controller.dart';
import 'package:voicehelp/screen/app_screen.dart';

class RecordView extends StatefulWidget {
  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  static const int maxDuration = 15;
  bool _recording = false;
  int _remainingDuration = maxDuration;
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    final _screenHight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AppScreenContainer(
        child: Container(
          padding: EdgeInsets.only(top: _screenHight / 4),
          child: ListView(
            children: [
              Column(
                children: [
                  RecordButton(() => _onRecordPushed(), this._recording),
                  Padding(
                    child: RecordTimer(_remainingDuration),
                    padding: EdgeInsets.only(top: 15),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    const tick = const Duration(milliseconds: 1000);

    _timer?.cancel();

    _timer = Timer.periodic(tick, (Timer t) async {
      if (!_recording) {
        t.cancel();
      } else {
        setState(() {
          _remainingDuration = maxDuration - t.tick;
        });
        if (_remainingDuration <= 0) {
          _stopRecording();
        }
      }
    });
  }

  void _onRecordPushed() async {
    bool isRecording = await SoundController.isRecording;
    if (!isRecording) {
      _startRecording();
    } else {
      _stopRecording();
    }
    setState(() {});
  }

  void _startRecording() async {
    await SoundController.startRecording();
    _startTimer();
    _recording = await SoundController.isRecording;
  }

  void _stopRecording() async {
    _timer?.cancel();
    _recording = !await SoundController.isRecording;
    setState(() {
      _remainingDuration = maxDuration;
    });
    await SoundController.stopRecording(this._manageRecordShowDialog);
  }

  void _manageRecordShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => RecordDialog());
  }
}
