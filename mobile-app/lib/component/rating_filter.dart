import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingFilter extends StatefulWidget {
  final Function(int) _onRateCallback;

  RatingFilter(this._onRateCallback);

  @override
  State createState() => RatingFilterState(this._onRateCallback);
}

class RatingFilterState extends State<RatingFilter> {
  bool _isFiltering = false;
  int _rate = 1;
  final Function(int) _onRateCallback;

  RatingFilterState(this._onRateCallback);

  @override
  Widget build(BuildContext context) {
    if (_isFiltering) {
      return buildFilter();
    }
    return RaisedButton(
      onPressed: () => {
        setState(() {
          _isFiltering = true;
        })
      },
      child: Text("Open filter"),
    );
  }

  Widget buildFilter() {
    return Row(
      children: [
        RatingBar.builder(
          itemSize: 24.0,
          initialRating: 1,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (double rating) {
            _rate = rating.toInt();
          },
          updateOnDrag: true,
        ),
        RaisedButton(
            onPressed: () => {_onRateCallback(_rate)}, child: Text("Filter")),
        RaisedButton(
            onPressed: () => {
                  setState(() {
                    _isFiltering = false;
                    _onRateCallback(0);
                  })
                },
            child: Text("Remove"))
      ],
    );
  }
}
