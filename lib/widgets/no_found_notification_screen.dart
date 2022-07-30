import 'package:flutter/material.dart';

import '../shared/utils/language.dart';

class NoFoundNotificationScreen extends StatefulWidget {
  @override
  _NoFoundNotificationScreenState createState() =>
      _NoFoundNotificationScreenState();
}

class _NoFoundNotificationScreenState extends State<NoFoundNotificationScreen> {
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
          LanguageConstants.bildirimBulunamadi[LanguageConstants.languageFlag]),
    );
  }
}
