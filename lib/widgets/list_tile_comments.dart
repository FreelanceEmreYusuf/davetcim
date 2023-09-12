import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:davetcim/widgets/star_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/enums/corporation_event_log_enum.dart';
import '../src/admin_corporate_panel/corporation_analysis/corporation_analysis_view_model.dart';
import '../src/comments/comments_view_model.dart';


class ListTileComments extends StatefulWidget {
  final String comment;
  final DateTime date;
  final String userName;
  final int star;
  final int corporationId;
  const ListTileComments(this.comment, this.date, this.userName, this.star, this.corporationId);
  @override
  _ListTileCommentsState createState() => _ListTileCommentsState();
}

class _ListTileCommentsState extends State<ListTileComments> {

  Widget trailingWidget = null;
  int oldRating = 0;

  @override
  Widget build(BuildContext context) {
    if(ApplicationSession.userSession.username == widget.userName)
      trailingWidget = MaterialButton(
        onPressed: () async{
          CommentsViewModel commentsViewModel = CommentsViewModel();
          oldRating = await commentsViewModel.getOldRating(widget.corporationId);
          setState(() {
            oldRating = oldRating;
          });
          await commentsViewModel.deleteUserComment(context, widget.corporationId, oldRating);
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.delete,
            color: Colors.redAccent,
          ),
        ),
      );

    return ListTile(
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
          onTap: () {},
      trailing: trailingWidget
        );
  }
}
