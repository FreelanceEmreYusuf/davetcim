import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/shared/models/reservation_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/language.dart';

import '../environments/db_constants.dart';
import '../models/corporation_model.dart';
import '../models/customer_model.dart';

class ReservationHelper {

  Future<ReservationModel> getReservation(int reservationId) async {
    Database db = Database();
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('id', isEqualTo: reservationId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      ReservationModel reservationModel = ReservationModel.fromMap(list[0].data());
      return reservationModel;
    }

    return null;
  }
}
