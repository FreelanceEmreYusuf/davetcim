import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/environments/db_constants.dart';
import '../../shared/models/customer_model.dart';
import '../../shared/models/notification_model.dart';
import '../../shared/services/database.dart';
import '../../shared/sessions/application_session.dart';
import '../../shared/utils/utils.dart';
import '../../widgets/list_tile_notifications_editing.dart';
import '../../widgets/no_found_notification_screen.dart';
import 'notifications_view.dart';

class NotificationsViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<Widget>> getNotificationList() async {
    List<Widget> listings = [];
    CollectionReference notRef =
    db.getCollectionRef(DBConstants.notificationsDb);
    bool isForAdmin = ApplicationSession.userSession.roleId == 3;

    var response;
    if (isForAdmin) {
      response = await notRef
          .where('corporationId', isEqualTo: ApplicationSession.userSession.corporationId)
          .where('isForAdmin', isEqualTo: true)
       //   .orderBy('notificationCreateDate', descending: true)
       //   .orderBy('id', descending: true)
          .get();
    } else {
      response = await notRef
          .where('customerId', isEqualTo: ApplicationSession.userSession.id)
     //     .where('isForAdmin', isEqualTo: false)
          .orderBy('notificationCreateDate', descending: true)
          .orderBy('id', descending: true)
          .get();
    }

    var list = response.docs;
    if (list.length > 0) {
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        listings.add(ListTileNotificationsEditing(item['text'], item["id"],
            item["basketId"], item["commentId"], item["categoryId"],
            item["isForAdmin"]));
        listings.add(Divider(
          thickness: 1,
        ));
      }
    } else {
      listings.add(NoFoundNotificationScreen());
    }
    return listings;
  }

  Future<void> deleteNotification(BuildContext context, int id) async {
    CollectionReference notRef =
    db.getCollectionRef(DBConstants.notificationsDb);
    var response = await notRef.where('id', isEqualTo: id).get();
    var list = response.docs;
    if (list.length > 0) {
      list[0].reference.delete();
      updateUserNotificationCount();
      Utils.navigateToPage(context, NotificationsView());
    }
  }

  Future<void> updateUserNotificationCount() async {
    if (ApplicationSession.userSession != null) {
      CollectionReference notRef = db.getCollectionRef(DBConstants.customerDB);
      var response = await notRef
          .where('id', isEqualTo: ApplicationSession.userSession.id)
          .get();
      var list = response.docs;
      if (list.length > 0) {
        CustomerModel customer = CustomerModel.fromMap(list[0].data());
        int notificationCount = customer.notificationCount - 1;
        Map<String, dynamic> customerMap = customer.toMap();
        customerMap['notificationCount'] = notificationCount;
        db.editCollectionRef("Customer", customerMap);
        ApplicationSession.notificationCount = notificationCount;
      }
    }
  }

  Future<void> sendNotificationsToAdminCompanyUsers(BuildContext context,
      int corporationId, int commentId, int reservationId,  String text) async {
    String offerMessage = "";

    if (commentId > 0) {
      offerMessage = "Konu: Yeni bir yorum onayınız var" +
          "\n" +
          " Yorum Mesajı: " +
          text +
          "\n" +
          " Gönderen: " +
          ApplicationSession.userSession.username +
          "\n" +
          " İşlem Tarihi :" +
          DateTime.now().toString().substring(0, 10);
    } else if (reservationId > 0) {
      offerMessage = "Konu: Yeni bir rezervasyon talebi var" +
          "\n" +
          " Rezervasyon Talep Mesajı: " +
          text +
          "\n" +
          " Gönderen: " +
          ApplicationSession.userSession.username +
          "\n" +
          " İşlem Tarihi :" +
          DateTime.now().toString().substring(0, 10);
    }


    CollectionReference docsRef =
      db.getCollectionRef(DBConstants.customerDB);
    var response = await docsRef
        .where('corporationId', isEqualTo: corporationId)
        .get();

    var list = response.docs;
    for (int i = 0; i < list.length; i++) {
      CustomerModel customer = CustomerModel.fromMap(list[i].data());
      int notificationCount = customer.notificationCount + 1;
      Map<String, dynamic> customerMap = customer.toMap();
      customerMap['notificationCount'] = notificationCount;
      db.editCollectionRef("Customer", customerMap);

      NotificationModel notificationModel = new NotificationModel(
        id: new DateTime.now().millisecondsSinceEpoch,
        corporationId: corporationId,
        customerId: ApplicationSession.userSession.id,
        commentId: commentId,
        reservationId: reservationId,
        isForAdmin : true,
        notificationCreateDate: Timestamp.now(),
        notificationOwner: ApplicationSession.userSession.username,
        text: offerMessage
      );
      db.editCollectionRef(DBConstants.notificationsDb, notificationModel.toMap());
    }
  }

}