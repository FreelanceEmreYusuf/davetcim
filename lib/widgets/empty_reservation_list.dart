import 'package:davetcim/shared/environments/const.dart';
import 'package:flutter/material.dart';

import '../screens/notifications.dart';
import 'badge.dart';

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
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            widget.dateTime.toString().substring(0,10)+" Rezervasyonları",
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: IconBadge(
                icon: Icons.notifications,
                size: 22.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Notifications();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Bu tarih için rezervasyon bulunamadı',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white60,
                    fontStyle: FontStyle.italic,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(10.0, 10.0),
                        blurRadius: 2.0,
                        color: Colors.black54,
                      ),
                      Shadow(
                        offset: Offset(10.0, 10.0),
                        blurRadius: 1.0,
                        color: Colors.black54,
                      ),
                    ],
                    fontFamily: 'RobotoMono',
                  ),
                  overflow: TextOverflow.clip,
                ),
                color: Constants.lightPrimary,
              ),
            ],
          ))
    );
  }
}
