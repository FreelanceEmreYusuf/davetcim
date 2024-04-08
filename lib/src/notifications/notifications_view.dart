import 'package:flutter/material.dart';
import '../../widgets/app_bar/app_bar_view.dart';
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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(pageName: "Bildirimler", isHomnePageIconVisible: true, isNotificationsIconVisible: false, isPopUpMenuActive: true),
        body: SafeArea(
            child: Container(
                child: Column(children: <Widget>[
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20.0),
                      children: listings, // <<<<< Note this change for the return type
                    ),
                  )
                ]))));
  }
}
