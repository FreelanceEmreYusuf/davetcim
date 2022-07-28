import 'package:davetcim/widgets/smooth_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/environments/const.dart';

class StarWidget extends StatefulWidget {
  int starCount;
  String raters;
  final DateTime date;

  StarWidget(
      {Key key,
        @required this.starCount,
        @required this.raters,
        @required this.date})
      : super(key: key);
  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<StarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          SmoothStarRating(
              starCount: widget.starCount,
              color: Constants.ratingBG,
              allowHalfRating: true,
              rating: double.parse(widget.starCount.toString()),
              size: 12.0),
          //SizedBox(height: MediaQuery.of(context).size.width / 20),
          Text(
            widget.raters.toString() +
                "\n" +
                DateFormat('yyyy-MM-dd – HH:mm').format(widget.date).toString(),
            // " 5.5 (5.5 Reviews)",
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
