import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:flutter/material.dart';

import '../../shared/sessions/application_session.dart';
import '../../shared/utils/language.dart';
import '../../widgets/app_bar/app_bar_view.dart';
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
        appBar: AppBarMenu(pageName: "Bildirimler", isHomnePageIconVisible: true, isNotificationsIconVisible: false, isPopUpMenuActive: true),
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
