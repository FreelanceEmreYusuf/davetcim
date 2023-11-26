import 'package:davetcim/shared/helpers/notification_helper.dart';
import 'package:davetcim/shared/models/notification_model.dart';
import 'package:davetcim/shared/sessions/application_cache.dart';
import 'package:flutter/material.dart';
import '../shared/utils/language.dart';
import '../src/notifications/notifications_view_model.dart';


class ListTileNotificationsEditing extends StatefulWidget {
  final NotificationModel notificationModel;
  const ListTileNotificationsEditing(
      this.notificationModel);
  @override
  _ListTileNotificationsEditingState createState() =>
      _ListTileNotificationsEditingState();
}

class _ListTileNotificationsEditingState
    extends State<ListTileNotificationsEditing> {
  void deleteNotification(int id) async {
    NotificationsViewModel notificationsViewModel = NotificationsViewModel();
    notificationsViewModel.deleteNotification(context, id, ApplicationCache.userCache.id);
  }

  void goToNotificationDetail() async {
    NotificationHelper notificationHelper = NotificationHelper();
    notificationHelper.landToNotificationPage(context, widget.notificationModel);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        goToNotificationDetail();
      },
      leading: CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ),
      title: Text(widget.notificationModel.text),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          size: 20.0,
        ),
        color: Colors.red,
        splashColor: Colors.red,
        onPressed: () {
          deleteNotification(widget.notificationModel.id);
        },
        tooltip: LanguageConstants.sil[LanguageConstants.languageFlag],
      ),
    );
  }
}
