import 'package:davetcim/widgets/smooth_star_rating.dart';
import 'package:flutter/material.dart';
import '../shared/environments/const.dart';
import '../shared/utils/language.dart';

class StarAndComment extends StatefulWidget {
  int starCount;
  double rating;
  int raters;

  StarAndComment(
      {Key key,
        @required this.starCount,
        @required this.rating,
        @required this.raters})
      : super(key: key);
  @override
  _StarAndCommentState createState() => _StarAndCommentState();
}

class _StarAndCommentState extends State<StarAndComment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
      child: Row(
        children: <Widget>[
          SizedBox(width: MediaQuery.of(context).size.width / 6),
          SmoothStarRating(
              starCount: widget.starCount,
              color: Constants.ratingBG,
              allowHalfRating: true,
              rating: widget.rating,
              size: 18.0),
          SizedBox(width: 10.0),
          Text(
            widget.rating.toString() +
                " (" +
                widget.raters.toString() +
                " " +
                LanguageConstants.incelemeler[LanguageConstants.languageFlag] +
                ")",
            // " 5.5 (5.5 Reviews)",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
