import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/combo_generic_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/dto/basket_user_model.dart';
import '../../../shared/models/corporation_model.dart';
import '../../../shared/models/reservation_model.dart';

class SummaryBasketViewModel extends ChangeNotifier {
  Database db = Database();

  Future<bool> controReeservation(BasketUserModel basketModel) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('sessionId', isEqualTo: basketModel.selectedSessionModel.id)
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

    ReservationModel reservationModel = new ReservationModel(
      id: new DateTime.now().millisecondsSinceEpoch,
      corporationId: basketModel.corporationId,
      customerId: ApplicationSession.userSession.id,
      cost: basketModel.totalPrice,
      date: basketModel.date,
      description: description,
      sessionId: basketModel.selectedSessionModel.id,
      isMoneyTransfered: false
    );

    db.editCollectionRef(DBConstants.corporationReservationsDb, reservationModel.toMap());
    return reservationModel;
  }




}
