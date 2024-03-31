import 'package:flutter/material.dart';

import '../shared/utils/language.dart';

class NoFoundDataScreen extends StatefulWidget {
  final String keyText;
  NoFoundDataScreen(
      {Key key,
        @required this.keyText,})
      : super(key: key);
  @override
  _NoFoundDataScreenState createState() =>
      _NoFoundDataScreenState();
}

class _NoFoundDataScreenState extends State<NoFoundDataScreen> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => {},
      leading: CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.warning,
          color: Colors.white,
        ),
      ),
      title: Text(
          widget.keyText),
    );
  }
}
