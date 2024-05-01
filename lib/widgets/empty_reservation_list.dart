import 'package:davetcim/shared/environments/const.dart';
import 'package:flutter/material.dart';

import '../screens/notifications.dart';
import 'app_bar/app_bar_view.dart';
import 'badge.dart';
import 'no_found_notification_screen.dart';

class EmptyReservationList extends StatefulWidget {
  @override
  State<EmptyReservationList> createState() => _EmptyReservationListState();

  final DateTime dateTime;
  const EmptyReservationList(this.dateTime);
}

class _EmptyReservationListState extends State<EmptyReservationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(pageName: widget.dateTime.toString().substring(0,10), isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: NoFoundDataScreen(keyText: widget.dateTime.toString().substring(0,10)+" tarihi için kayıt bulunamadı"),
                  ),
              ),
            ],
          ))
    );
  }
}
