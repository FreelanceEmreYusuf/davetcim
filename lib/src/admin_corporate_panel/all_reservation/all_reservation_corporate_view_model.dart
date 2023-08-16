import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/service_corporate_pool_model.dart';
import 'package:davetcim/shared/models/service_pool_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/dto/reservation_detail_view_dto.dart';
import '../../../shared/enums/reservation_status_enum.dart';
import '../../../shared/helpers/customer_helper.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/services/database.dart';
import '../../../shared/utils/date_utils.dart';
import '../seans/seans_corporate_view_model.dart';

class AllReservationCorporateViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ReservationModel>> getAllReservationlist(int corporateId) async {
    var response = await db
        .getCollectionRef("CorporationReservations")
        .where('corporationId', isEqualTo: corporateId)
        .where('reservationStatus',
            whereIn: ReservationStatusEnumConverter.adminHistoryViewedReservationStatus())
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