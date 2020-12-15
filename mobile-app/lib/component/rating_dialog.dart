import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:voicehelp/service/record_service.dart';

class RatingDialog extends StatefulWidget {
  final RatingDialogState state;
  RatingDialog(_recordId) : state = RatingDialogState(_recordId);

  @override
  State createState() => state;

  get rating => state.rating;
}

class RatingDialogState extends State {
  final String _recordId;
  int _rating = 3;

  RatingDialogState(this._recordId);

  get rating => _rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            _rating = rating.toInt();
          },
          updateOnDrag: true,
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton(
              child: Text('Rate'),
              onPressed: () => {
                onRateButtonPressed(_recordId, _rating),
                Navigator.of(context).pop(),
              },
            ),
            RaisedButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop())
          ],
        ),
      ],
    );
  }
}

void onRateButtonPressed(String _recordId, int _rating){
  addRecordRating(_recordId, _rating);
}
