import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../shared/environments/const.dart';
import '../shared/utils/language.dart';
import '../src/comments/comments_view_model.dart';

class AddCommentsWidget extends StatefulWidget {
  final int corporationId;
  const AddCommentsWidget(this.corporationId);

  @override
  _AddCommentsWidgetState createState() => _AddCommentsWidgetState();
}

class _AddCommentsWidgetState extends State<AddCommentsWidget> {
  TextEditingController commentController = TextEditingController();
  @override
  double _rating;

  void initState() {
    _rating = Constants.ratePoint;
  }

  void fillStars(double rating) {
    setState(() {
      _rating = rating;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(children: <Widget>[
        RatingBar.builder(
          initialRating: _rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            fillStars(rating);
          },
        ),
        SizedBox(height: 10.0),
        ListTile(
          title: Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: commentController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText:
                    LanguageConstants.yorumGir[LanguageConstants.languageFlag],
              ),
            ),
          ),
          onTap: () {},
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1),
                color: Colors.white60,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                splashColor: Colors.redAccent,
                icon: const Icon(Icons.send),
                tooltip:
                    LanguageConstants.gonder[LanguageConstants.languageFlag],
                onPressed: () async {
                  CommentsViewModel cvm = CommentsViewModel();
                  cvm.addUserComment(context, widget.corporationId, this._rating.toInt(), commentController.text);
                },
              ),
            ),
            Text(LanguageConstants.gonder[LanguageConstants.languageFlag]),
          ],
        ),
        SizedBox(height: 10.0),
      ]),
    );
  }
}
