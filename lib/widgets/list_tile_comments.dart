import 'package:davetcim/widgets/star_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ListTileComments extends StatefulWidget {
  final String comment;
  final DateTime date;
  final String userName;
  final int star;
  const ListTileComments(this.comment, this.date, this.userName, this.star);
  @override
  _ListTileCommentsState createState() => _ListTileCommentsState();
}

class _ListTileCommentsState extends State<ListTileComments> {
  @override
  Widget build(BuildContext context) {
    String text = widget.userName.toString() +
        " / " +
        DateFormat('yyyy-MM-dd – HH:mm').format(widget.date).toString();
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
    );
  }
}
