import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/enums/reservation_status_enum.dart';
import 'package:flutter/material.dart';

import '../../shared/enums/customer_role_enum.dart';
import '../../shared/environments/db_constants.dart';
import '../../shared/helpers/customer_helper.dart';
import '../../shared/models/customer_model.dart';
import '../../shared/models/notification_model.dart';
import '../../shared/services/database.dart';
import '../../shared/sessions/user_state.dart';
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
    bool isForAdmin = CustomerRoleEnumConverter.isAdmin(UserState.roleId);

    var response;
    if (isForAdmin) {
      response = await notRef
          .where('corporationId', isEqualTo: UserState.corporationId)
          .where('recipientCustomerId', isEqualTo: UserState.id)
          .where('isForAdmin', isEqualTo: true)
          .orderBy('notificationCreateDate', descending: true)
          .orderBy('id', descending: true)
          .get();
    } else {
      response = await notRef
          .where('recipientCustomerId', isEqualTo: UserState.id)
          .orderBy('notificationCreateDate', descending: true)
          .orderBy('id', descending: true)
          .get();
    }

    var list = response.docs;
    if (list.length > 0) {
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        listings.add(ListTileNotificationsEditing(NotificationModel.fromMap(item)));
        listings.add(Divider(
          thickness: 1,
        ));
      }
    } else {
      listings.add(NoFoundDataScreen(keyText: "Bildirim bulunamadı",));
    }
    return listings;
  }

  Future<void> deleteNotification(BuildContext context, int id, int customerId) async {
    CollectionReference notRef =
    db.getCollectionRef(DBConstants.notificationsDb);
    var response = await notRef.where('id', isEqualTo: id).get();
    var list = response.docs;
    if (list.length > 0) {
      list[0].reference.delete();
      updateUserNotificationCount(customerId);
      Utils.navigateToPage(context, NotificationsView());
    }
  }

  Future<void> updateUserNotificationCount(int customerId) async {
    if (UserState.isPresent()) {
      CollectionReference notRef = db.getCollectionRef(DBConstants.customerDB);
      var response = await notRef
          .where('id', isEqualTo: customerId)
          .get();
      var list = response.docs;
      if (list.length > 0) {
        CustomerModel customer = CustomerModel.fromMap(list[0].data());
        int notificationCount = customer.notificationCount - 1;
        customer.notificationCount = notificationCount;
        db.editCollectionRef(DBConstants.customerDB, customer.toMap());
        UserState.notificationCount = notificationCount;
      }
    }
  }

  Future<void> sendNotificationToUser(BuildContext context,
      int corporationId, int customerId, int commentId, int reservationId,
      int reservationStatus, bool isApproved, String text, String offerMessage) async {
    if (offerMessage.isEmpty) {
      if (commentId > 0) {
        if (isApproved) {
          offerMessage = "Konu: Yorum Mesajınız Onaylandı" +
              "\n" +
              " Yorum Mesajı: " +
              text +
              "\n" +
              " İşlem Tarihi :" +
              DateTime.now().toString().substring(0, 10);
        } else {
          offerMessage = "Konu: Yorum Mesajınız İptal Edildi" +
              "\n" +
              " Yorum Mesajı: " +
              text +
              "\n" +
              " İşlem Tarihi :" +
              DateTime.now().toString().substring(0, 10);
        }

      } else if (reservationId > 0) {
        if (isApproved) {
          if (reservationStatus == ReservationStatusEnum.userOffer.index) {
            offerMessage = "Konu: Tekliifiniz Oluşturuldu" +
                "\n" +
                " İşlem Tarihi :" +
                DateTime.now().toString().substring(0, 10);
          } else if (reservationStatus == ReservationStatusEnum.preReservation.index) {
            offerMessage = "Konu: Teklifiniz Opsiyonlandı" +
                "\n" +
                " Opsiyonlanma Mesajı: " +
                text +
                "\n" +
                " İşlem Tarihi :" +
                DateTime.now().toString().substring(0, 10);
          } else if (reservationStatus == ReservationStatusEnum.reservation.index) {
            offerMessage = "Konu: Opsiyonunuz Satışa Dönüştürüldü." +
                "\n" +
                " Satış Mesajı: " +
                text +
                "\n" +
                " İşlem Tarihi :" +
                DateTime.now().toString().substring(0, 10);
          }
        } else {
          if (reservationStatus == ReservationStatusEnum.userOffer.index) {
            offerMessage = "Konu: Opsiyonunuz Teklife Çevrildi" +
                "\n" +
                " Teklif Mesajı: " +
                text +
                "\n" +
                " İşlem Tarihi :" +
                DateTime.now().toString().substring(0, 10);
          } else if (reservationStatus == ReservationStatusEnum.preReservation.index) {
            offerMessage = "Konu: Satışınız Tekar Opsiyon Statüsüne Alındı" +
                "\n" +
                " İşlem Mesajı: " +
                text +
                "\n" +
                " İşlem Tarihi :" +
                DateTime.now().toString().substring(0, 10);
          } else {
            offerMessage = "Konu: Teklifiniz İptal Edildi." +
                "\n" +
                " İşlem Mesajı: " +
                text +
                "\n" +
                " İşlem Tarihi :" +
                DateTime.now().toString().substring(0, 10);
          }
        }
      }
    }
    CustomerHelper customerHelper = CustomerHelper();
    CustomerModel customer = await customerHelper.getCustomer(customerId);
    int notificationCount = customer.notificationCount + 1;
    Map<String, dynamic> customerMap = customer.toMap();
    customerMap['notificationCount'] = notificationCount;
    db.editCollectionRef("Customer", customerMap);

    NotificationModel notificationModel = new NotificationModel(
        id: new DateTime.now().millisecondsSinceEpoch,
        corporationId: corporationId,
        customerId: UserState.id,
        recipientCustomerId: customerId,
        commentId: commentId,
        reservationId: reservationId,
        isForAdmin : false,
        notificationCreateDate: Timestamp.now(),
        notificationOwner: customer.username,
        text: offerMessage
    );
    db.editCollectionRef(DBConstants.notificationsDb, notificationModel.toMap());
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
          UserState.username +
          "\n" +
          " İşlem Tarihi :" +
          DateTime.now().toString().substring(0, 10);
    } else if (reservationId > 0) {
      offerMessage = "Konu: Yeni bir teklif talebiniz var" +
          "\n" +
          " Teklif Talep Mesajı: " +
          text +
          "\n" +
          " Gönderen: " +
          UserState.username +
          "\n" +
          " İşlem Tarihi :" +
          DateTime.now().toString().substring(0, 10);
    }


    CollectionReference docsRef =
      db.getCollectionRef(DBConstants.customerDB);
    var response = await docsRef
        .where('corporationId', isEqualTo: corporationId)
        .where('roleId', isEqualTo: CustomerRoleEnum.organizationOwner.index)
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
        customerId: UserState.id,
        recipientCustomerId: customer.id,
        commentId: commentId,
        reservationId: reservationId,
        isForAdmin : true,
        notificationCreateDate: Timestamp.now(),
        notificationOwner: UserState.username,
        text: offerMessage
      );
      db.editCollectionRef(DBConstants.notificationsDb, notificationModel.toMap());
    }
  }

  Future<void> deleteNotificationsFromAdminUsers(BuildContext context,
      int commentId, int reservationId) async {

    CollectionReference docsRef =
    db.getCollectionRef(DBConstants.notificationsDb);
    var response;
    if (reservationId > 0) {
      response = await docsRef
          .where('reservationId', isEqualTo: reservationId)
          .where('isForAdmin', isEqualTo: true)
          .get();
    } else {
      response = await docsRef
          .where('commentId', isEqualTo: commentId)
          .where('isForAdmin', isEqualTo: true)
          .get();
    }

    var list = response.docs;
    for (int i = 0; i < list.length; i++) {
      NotificationModel notification = NotificationModel.fromMap(list[i].data());
      deleteNotification(context, notification.id, notification.recipientCustomerId);
    }
  }
}