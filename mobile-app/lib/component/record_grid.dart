import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:voicehelp/client/record_client.dart';
import 'package:voicehelp/component/rating_dialog.dart';

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
      physics: const AlwaysScrollableScrollPhysics(),
      children:
          _records.map((record) => _buildRecordTail(context, record)).toList(),
    );
  }

  Widget _buildRecordTail(BuildContext context, RecordResponse record) {
    return GestureDetector(
      onTap: () => _onRecordTapCallback(record),
      onLongPress: () => showRatingDialog(context, record.recordId),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                )),
               RatingBar.builder(
                itemSize: 12.0,
                initialRating: record.recordRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {},
                updateOnDrag: true,
                ignoreGestures: true,
              ),
          ],
        ),
      ),
    );
  }

  void showRatingDialog(BuildContext context, String recordId) {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => RatingDialog(recordId));
  }
}
