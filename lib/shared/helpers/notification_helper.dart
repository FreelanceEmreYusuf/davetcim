import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/shared/helpers/reservation_helper.dart';
import 'package:davetcim/shared/models/notification_model.dart';
import 'package:davetcim/shared/models/reservation_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:flutter/cupertino.dart';

import '../../src/admin_corporate_panel/reservation/reservation_corporate_detail_view.dart';
import '../../src/user_reservations/user_reservation_detail_view.dart';
import '../environments/db_constants.dart';
import '../models/corporation_model.dart';
import '../models/customer_model.dart';
import '../utils/utils.dart';

class NotificationHelper {

  Future<void> landToNotificationPage(BuildContext context, NotificationModel notificationModel) async {
    if (notificationModel.reservationId > 0) {
      ReservationHelper reservationHelper = ReservationHelper();
      ReservationModel reservationModel = await
        reservationHelper.getReservation(notificationModel.reservationId);
      if (notificationModel.isForAdmin) {
        Utils.navigateToPage(context, ReservationCorporateDetailScreen(reservationModel : reservationModel, isFromNotification: true));
      } else {
        Utils.navigateToPage(context, UserResevationDetailScreen(reservationModel : reservationModel, isFromNotification: true));
      }

    }
  }


}
