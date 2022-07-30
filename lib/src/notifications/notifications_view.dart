import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:flutter/material.dart';

import '../../shared/sessions/application_session.dart';
import '../../shared/utils/language.dart';
import '../../widgets/list_tile_notifications_editing.dart';
import '../../widgets/no_found_notification_screen.dart';
import '../../widgets/popup_menu/popup_menu.dart';
import 'notifications_view_model.dart';


class NotificationsView extends StatefulWidget {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  List<Widget> listings = [];

  @override
  void initState() {
    _getListings();
  }

  void _getListings() async {
    NotificationsViewModel notificationsViewModel = NotificationsViewModel();
    listings = await notificationsViewModel.getNotificationList();

    setState(() {
      listings = listings;
    });
  }

  List<Widget> getListWidget(List _listings) {
    // <<<<< Note this change for the return type
    List listings = List<Widget>();
    int i = 0;
    for (i = 0; i < _listings.length; i++) {
      listings.add(_listings[i]);
    }
    return listings;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MainScreen();
                    },
                  ),
                );
              },
              tooltip:
              LanguageConstants.bildirimler[LanguageConstants.languageFlag],
            ),
            new PopUpMenu(),
          ],
          centerTitle: true,
          title: Text(
            LanguageConstants.bildirimler[LanguageConstants.languageFlag],
          ),
          elevation: 0.0,
        ),
        body: SafeArea(
            child: Container(
                child: Column(children: <Widget>[
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20.0),
                      children: getListWidget(
                          listings), // <<<<< Note this change for the return type
                    ),
                  )
                ]))));
  }
}
