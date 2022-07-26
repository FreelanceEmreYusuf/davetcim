import 'package:flutter/cupertino.dart';

import '../../shared/models/reservation_model.dart';
import '../../shared/services/database.dart';

class ReservationViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ReservationModel>> getReservationlist(int corporateId) async {
    var response = await db
        .getCollectionRef("CorporationReservations")
        .where('corporationId', isEqualTo: corporateId)
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

}