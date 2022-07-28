import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/src/comments/comments_view_model.dart';
import 'package:davetcim/widgets/star_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../shared/utils/language.dart';


class ListTileCommentsWithEditing extends StatefulWidget {
  final String comment;
  final DateTime date;
  final String userName;
  final int star;
  final int corporationId;
  const ListTileCommentsWithEditing(this.comment, this.date, this.userName,
      this.star, this.corporationId);
  @override
  _ListTileCommentsWithEditingState createState() =>
      _ListTileCommentsWithEditingState();
}

class _ListTileCommentsWithEditingState
    extends State<ListTileCommentsWithEditing> {
  int oldRating;

  void initState() {
    setOldRating();
  }

  void setOldRating() async {
    CommentsViewModel commentsViewModel = CommentsViewModel();
    int oldRatingTemp =  await commentsViewModel.getOldRating(widget.corporationId);
    setState(() {
      oldRating = oldRatingTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    String text = widget.userName.toString() +
        " / " +
        DateFormat('yyyy-MM-dd – HH:mm').format(widget.date).toString();
    return ListTile(
      onTap: () => {},
      leading: CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.comment,
          color: Colors.white,
        ),
      ),
      title: Text(widget.comment),
      subtitle: StarWidget(
        starCount: widget.star,
        raters: widget.userName,
        date: widget.date,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          size: 20.0,
        ),
        color: Colors.red,
        splashColor: Colors.red,
        onPressed: () async {
          CommentsViewModel commentsViewModel = CommentsViewModel();
          commentsViewModel.deleteUserComment(context, widget.corporationId, oldRating);
        },
        tooltip: LanguageConstants.sil[LanguageConstants.languageFlag],
      ),
    );
  }
}
