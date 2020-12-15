import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:voicehelp/client/record_client.dart';
import 'package:voicehelp/component/rating_filter.dart';
import 'package:voicehelp/component/record_grid.dart';
import 'package:voicehelp/component/record_player.dart';
import 'package:voicehelp/screen/app_screen.dart';
import 'package:voicehelp/service/record_service.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  RecordPlayer _recordPlayer;

  List<RecordResponse> _records = List();
  int _currentFilter = 0;
  bool loading = true;

  _HomeViewState() {
    _recordPlayer = RecordPlayer(
        this._getNextRecord, this._getPreviousRecord, this._onRecordChange);
    reloadRecords(0);
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenContainer(
      child: !loading
          ? RefreshIndicator(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RatingFilter((filter) {
                    setState(() {
                      loading = true;
                    });
                    return reloadRecords(filter);
                  }),
                  new Expanded(
                      child: RecordGrid(_records, this._onRecordSelected,
                          this._recordPlayer.currentRecord)),
                  _recordPlayer
                ],
              ),
              onRefresh: () => reloadRecords(_currentFilter))
          : Center(
              child: CircularProgressIndicator(backgroundColor: Colors.black)),
    );
  }

  Future<void> reloadRecords(int filter) async {
    List<RecordResponse> records = await getRecords();
    if (filter != null) {
      records =
          records.where((record) => record.recordRating >= filter).toList();
    }
    _currentFilter = filter;
    setState(() {
      _records = records;
      loading = false;
    });
  }

  int getRecordLenght() {
    return (_records == null) ? 0 : _records.length;
  }

  RecordResponse _getNextRecord() {
    var nextRecordIndex =
        _records.indexOf(this._recordPlayer.currentRecord) + 1;
    if (nextRecordIndex < _records.length) {
      return _records[nextRecordIndex];
    }
    return null;
  }

  RecordResponse _getPreviousRecord() {
    var previousRecordIndex =
        _records.indexOf(this._recordPlayer.currentRecord) - 1;
    if (previousRecordIndex >= 0) {
      return _records[previousRecordIndex];
    }
    return null;
  }

  //
  void _onRecordChange(RecordResponse record) {
    var recordExists = _records.contains(record);
    if (!recordExists) {
      Scaffold.of(context).showSnackBar(
          buildSnackBar("Playing record failed - try again later"));
      return;
    }
    setState(() {});
  }

  void _onRecordSelected(RecordResponse record) {
    if (!_records.contains(record)) {
      Scaffold.of(context).showSnackBar(
          buildSnackBar("Playing record failed - try again later"));
      return;
    }
    this._recordPlayer.playRecord(record);
    setState(() {});
  }

  SnackBar buildSnackBar(String text) => SnackBar(
        content: Text(text),
      );
}
