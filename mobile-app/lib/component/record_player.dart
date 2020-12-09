import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:voicehelp/client/record_client.dart';
import 'package:voicehelp/service/record_service.dart';

class RecordPlayer extends StatefulWidget {
  final RecordPlayerState state;

  RecordPlayer(
      RecordResponse Function() _getNextRecord,
      RecordResponse Function() _getPreviousRecord,
      void Function(RecordResponse) _recordChangedCallback)
      : state = RecordPlayerState(
            _getNextRecord, _getPreviousRecord, _recordChangedCallback);

  RecordPlayerState createState() => state;

  void playRecord(RecordResponse record) => state.playRecord(record);

  RecordResponse get currentRecord => state.currentRecord;
}

class RecordPlayerState extends State<RecordPlayer> {
  var _playing = false;
  RecordResponse _currentRecord;
  final RecordResponse Function() _getNextRecord;
  final RecordResponse Function() _getPreviousRecord;
  final void Function(RecordResponse record) _recordChangedCallback;
  final AudioPlayer audioPlayer;

  RecordPlayerState(
      this._getNextRecord, this._getPreviousRecord, this._recordChangedCallback)
      : audioPlayer = AudioPlayer() {
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState event) {
      if (event != AudioPlayerState.PLAYING) {
        setState(() {
          _playing = false;
        });
      }
    });
  }

  void playRecord(RecordResponse record) async {
    await audioPlayer.stop();
    this._currentRecord = record;
    _playCurrentRecord();
  }

  void _playCurrentRecord() async {
    if (_currentRecord == null) {
      return;
    }
    var currentRecordFilePath =
        await getRecordFilePath(_currentRecord.recordId);

    if (audioPlayer.state == AudioPlayerState.COMPLETED ||
        audioPlayer.state == AudioPlayerState.PAUSED) {
      setState(() {
        _playing = true;
      });
      audioPlayer.play(currentRecordFilePath, isLocal: true);
    }

    getRecordFile(_currentRecord.recordId).then((response) => {
          if (response.statusCode == 200)
            {
              setState(() {
                _playing = true;
              }),
              audioPlayer.play(currentRecordFilePath, isLocal: true),
              _recordChangedCallback(_currentRecord)
            }
        });
  }

  void _playNextRecord() async {
    await audioPlayer.stop();
    var recordToPlay = _getNextRecord();
    if (recordToPlay == null) {
      return;
    }
    playRecord(recordToPlay);
  }

  void _rewindRecord() async {
    audioPlayer.seek(Duration(seconds: 0));
    setState(() {});
  }

  void _playPreviousRecord() async {
    await audioPlayer.stop();
    var recordToPlay = _getPreviousRecord();
    if (recordToPlay == null) {
      return;
    }
    setState(() {});
  }

  RecordResponse get currentRecord => _currentRecord;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _currentRecord != null
              ? Text(
                  _currentRecord.recordName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                )
              : Text('Tap record to play'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Material(
                child: GestureDetector(
                  onTap: () => _rewindRecord(),
                  onDoubleTap: () => _playPreviousRecord(),
                  child: IconButton(
                    icon: Icon(Icons.fast_rewind),
                    splashRadius: 20,
                    splashColor: Colors.black12,
                    onPressed: () => {},
                  ),
                ),
                color: Colors.transparent,
              ),
              new Material(
                child: IconButton(
                  icon: Icon(_playing ? Icons.pause : Icons.play_arrow),
                  splashRadius: 20,
                  splashColor: Colors.black12,
                  onPressed: () => {
                    if (audioPlayer.state == AudioPlayerState.PLAYING)
                      {
                        setState(() => {_playing = false, audioPlayer.pause()})
                      }
                    else
                      {_playCurrentRecord()}
                  },
                ),
                color: Colors.transparent,
              ),
              new Material(
                child: IconButton(
                  icon: Icon(Icons.fast_forward),
                  splashRadius: 20,
                  splashColor: Colors.black12,
                  onPressed: () => {_playNextRecord()},
                ),
                color: Colors.transparent,
              )
            ],
          )
        ],
      ),
    );
  }
}
