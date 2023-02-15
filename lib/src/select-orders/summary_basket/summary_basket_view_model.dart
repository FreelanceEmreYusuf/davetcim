import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/combo_generic_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/dto/basket_user_model.dart';
import '../../../shared/enums/reservation_status_enum.dart';
import '../../../shared/models/corporation_model.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/sessions/user_basket_session.dart';

class SummaryBasketViewModel extends ChangeNotifier {
  Database db = Database();

  Future<bool> controReeservation(BasketUserModel basketModel) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('sessionId', isEqualTo: basketModel.selectedSessionModel.id)
        .where('isActive', isEqualTo: true)
        .where('date', isEqualTo: basketModel.date)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      return true;
    }

    return false;
  }

  Future<ReservationModel> createNewReservation(BasketUserModel basketModel, String description) async {
    bool hasReservation = await controReeservation(basketModel);
    if (hasReservation) {
      return null;
    }

    int reservationId = new DateTime.now().millisecondsSinceEpoch;

    ReservationModel reservationModel = new ReservationModel(
      id: reservationId,
      corporationId: basketModel.corporationId,
      customerId: ApplicationSession.userSession.id,
      cost: basketModel.totalPrice,
      date: basketModel.date,
      description: description,
      sessionId: basketModel.selectedSessionModel.id,
      reservationStatus: ReservationStatusEnum.newRecord.index,
      isActive: true,
      invitationCount: basketModel.orderBasketModel.count,
      invitationType: basketModel.orderBasketModel.invitationType,
      seatingArrangement: basketModel.orderBasketModel.sequenceOrder
    );

    db.editCollectionRef(DBConstants.corporationReservationsDb, reservationModel.toMap());
    await createNewReservationDetail(basketModel, reservationId);
    return reservationModel;
  }

  Future<void> createNewReservationDetail(BasketUserModel basketModel, int reservationId) async {
    int id = new DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < basketModel.servicePoolModel.length; i++) {
      ServicePoolModel model = basketModel.servicePoolModel[i];
      ReservationDetailModel reservationModel = new ReservationDetailModel(
          id: (id + i),
          reservationId: reservationId,
          foreignId: model.id,
          foreignType: "service",
      );

      db.editCollectionRef(DBConstants.reservationDetailDb, reservationModel.toMap());
    }
  }




}
