import 'package:flutter/material.dart';
import 'package:voicehelp/client/record_client.dart';

class RecordGrid extends StatelessWidget {
  final List<RecordResponse> _records;
  final void Function(RecordResponse) _onRecordTapCallback;
  final RecordResponse _currentPlayingRecord;

  RecordGrid(
      this._records, this._onRecordTapCallback, this._currentPlayingRecord);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      children: _records.map((record) => _buildRecordTail(record)).toList(),
    );
  }

  Widget _buildRecordTail(RecordResponse record) {
    return GestureDetector(
      onTap: () => _onRecordTapCallback(record),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_currentPlayingRecord == record
                ? Icons.music_note
                : Icons.play_arrow),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                record.recordName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
