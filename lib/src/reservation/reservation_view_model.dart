import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/models/reservation_model.dart';
import '../../shared/services/database.dart';
import '../../shared/utils/date_utils.dart';

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


  Stream<List<ReservationModel>> getReservationStreamlist(int corporateId, DateTime dateTime) {
    Stream<List<DocumentSnapshot>> reservationListInfo = db
        .getCollectionRef("CorporationReservations")
        .where('corporationId', isEqualTo: corporateId)
        .where('date', isEqualTo: DateConversionUtils.getCurrentDateAsInt(dateTime))
        .snapshots()
        .map((event) => event.docs);

    Stream<List<ReservationModel>> reservationModellist = reservationListInfo
        .map((event) => event.map((e) => ReservationModel.fromMap(e.data())).toList());

    return reservationModellist;
  }

}