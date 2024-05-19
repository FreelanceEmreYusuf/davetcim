import 'package:davetcim/shared/models/reservation_model.dart';
import 'package:davetcim/shared/services/database.dart';

import '../environments/db_constants.dart';

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

  Future<ReservationModel> getReservationBySessionId(int sessionId) async {
    Database db = Database();
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('sessionId', isEqualTo: sessionId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      ReservationModel reservationModel = ReservationModel.fromMap(list[0].data());
      return reservationModel;
    }

    return null;
  }
}
