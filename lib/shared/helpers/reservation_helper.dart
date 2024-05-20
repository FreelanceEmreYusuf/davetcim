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

  Future<List<ReservationModel>> getReservationListBySessionIdAndDate(int sessionId, int date) async {
    Database db = Database();
    List<ReservationModel> reservationList = [];
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('sessionId', isEqualTo: sessionId)
        .where('date', isEqualTo: date)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        reservationList.add(ReservationModel.fromMap(list[i].data()));
      }
    }

    return reservationList;
  }
}
