import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/enums/reservation_status_enum.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/services/database.dart';
import '../../notifications/notifications_view_model.dart';

class AllReservationCorporateViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ReservationModel>> getAllReservationlist(int corporateId) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('corporationId', isEqualTo: corporateId)
        .where('reservationStatus',
            whereIn: ReservationStatusEnumConverter.adminHistoryViewedReservationStatus())
        .orderBy('date', descending: true)
        .get();

    List<ReservationModel> corpModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        corpModelList.add(ReservationModel.fromMap(item));
      }
    }

    return corpModelList;
  }

  Future<List<ReservationModel>> getAllReservationlistForCalendar(int corporateId) async {
    var response = await db
        .getCollectionRef("CorporationReservations")
        .where('corporationId', isEqualTo: corporateId)
        .where('reservationStatus',
            whereIn: ReservationStatusEnumConverter.calenderReservationStatus())
        .get();

    List<ReservationModel> corpModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        corpModelList.add(ReservationModel.fromMap(item));
      }
    }

    return corpModelList;
  }

  Future<void> delayReservation(BuildContext context, ReservationModel reservationModel) async {
    await db.editCollectionRef(DBConstants.corporationReservationsDb, reservationModel.toMap());
    NotificationsViewModel notificationViewModel = NotificationsViewModel();

    String reservationStatusText = "";
    if (reservationModel.reservationStatus == ReservationStatusEnum.userOffer)  {
      reservationStatusText = "Teklifiniz ";
    } else if (reservationModel.reservationStatus == ReservationStatusEnum.preReservation)  {
      reservationStatusText = "Opsiyonlu rezervasyonunuz ";
    } else if (reservationModel.reservationStatus == ReservationStatusEnum.reservation)  {
      reservationStatusText = "Rezervasyonunuz ";
    }

    String offerMessage = "Konu: " + reservationStatusText + "firma tarafından " +
        DateConversionUtils.getDateTimeFromIntDate(reservationModel.date).toString().substring(0, 10)
        + " tarihine ertelendi." +
        "\n" +
        " İşlem Tarihi :" +
        DateTime.now().toString().substring(0, 10);

    notificationViewModel.sendNotificationToUser(context, reservationModel.corporationId,
        reservationModel.customerId,
        0, reservationModel.id,
        reservationModel.reservationStatus.index,
        true, reservationModel.description, offerMessage);
  }
}