import 'dart:async';

import 'package:flutter/material.dart';
import 'package:voicehelp/component/record_button.dart';
import 'package:voicehelp/controller/sound_controller.dart';
import 'package:voicehelp/screen/app_screen.dart';
import 'package:voicehelp/service/record_service.dart';

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
    TextEditingController recordNameController = TextEditingController();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What do you want to do with record ?'),
                    ),
                    TextField(
                      controller: recordNameController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter record name',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          uploadRecord(recordNameController.text)
                              .then((value) => {
                                    if (value != null &&
                                        value.statusCode == 200)
                                      {
                                        Scaffold.of(this.context)
                                            .showSnackBar(saveSuccessSnackBar)
                                      }
                                    else
                                      {
                                        Scaffold.of(this.context)
                                            .showSnackBar(saveFailSnackBare)
                                      }
                                  });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          //removeRecordFile();
                          Scaffold.of(this.context)
                              .showSnackBar(removedSnackBar);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Remove",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  final saveSuccessSnackBar = SnackBar(
    content: Text('Record saved!'),
  );

  final saveFailSnackBare = SnackBar(
    content: Text('Record save failure :('),
  );
  final removedSnackBar = SnackBar(
    content: Text('Record removed'),
  );
}
