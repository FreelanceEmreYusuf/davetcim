import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/environments/db_constants.dart';
import '../../shared/models/customer_model.dart';
import '../../shared/models/notification_model.dart';
import '../../shared/services/database.dart';
import '../../shared/sessions/application_session.dart';

class NotificationsViewModel extends ChangeNotifier {
  Database db = Database();

  Future<void> sendNotificationsToAdminCompanyUsers(BuildContext context,
      int corporationId, int commentId, String text) async {
    String offerMessage = "Konu: Yeni bir yorum onayınız var" +
        "\n" +
        " Yorum Mesajı: " +
        text +
        "\n" +
        " Gönderen: " +
        ApplicationSession.userSession.username +
        "\n" +
        " İşlem Tarihi :" +
        DateTime.now().toString().substring(0, 10);

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
        isForAdmin : true,
        notificationCreateDate: Timestamp.now(),
        notificationOwner: ApplicationSession.userSession.username,
        text: offerMessage
      );
      db.editCollectionRef(DBConstants.notificationsDb, notificationModel.toMap());
    }
  }

}