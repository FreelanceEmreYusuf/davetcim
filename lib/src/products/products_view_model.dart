import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/dto/product_filterer_dto.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/models/corporate_sessions_model.dart';
import '../../shared/models/reservation_model.dart';
import '../reservation/reservation_view_model.dart';

class ProductsViewModel extends ChangeNotifier {

  Database db = Database();

  Future<List<int>> filterCorporationListForReservations(ProductFiltererDto filter) async {
    int filterDate = DateConversionUtils.getCurrentDateAsInt(filter.date);
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('date', isEqualTo: filterDate)
        .where('isActive', isEqualTo: true)
        .get();

    List<int> corpModelListIDs = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      ReservationViewModel rvm = ReservationViewModel();
      List<CorporateSessionsModel> sessionList =
        await rvm.getSessionReservationForAllCorporatesExtraction(filterDate);

      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ReservationModel model = ReservationModel.fromMap(item);

        List<CorporateSessionsModel> sessionCorporationList = [];
        for (int s = 0; s < sessionList.length; s++) {
          CorporateSessionsModel sessionModel = sessionList[s];
          if (sessionModel.corporationId == model.corporationId) {
            sessionCorporationList.add(sessionModel);
          }
        }

        bool hasFullReservation = true;
        for (int s = 0; s < sessionCorporationList.length; s++) {
          CorporateSessionsModel sessionModel = sessionCorporationList[s];
          if (!sessionModel.hasReservation) {
            hasFullReservation = false;
            break;
          }
        }

        if (hasFullReservation) {
          corpModelListIDs.add(model.corporationId);
        }
      }
    }

    return corpModelListIDs;
  }


  Future<List<CorporationModel>> getCorporationList(ProductFiltererDto filter) async {
    Query list = db.getCollectionRef("Corporation");
    list = list.where('isActive', isEqualTo: true);
    if (int.parse(filter.region) > 0) {
      list = list.where('region', isEqualTo: filter.region);
    }
    if (!filter.district.contains('00')) {
      list = list.where('district', isEqualTo: filter.district);
    }
    if (filter.maxPopulation.isNotEmpty) {
      list = list.where('maxPopulation', isGreaterThanOrEqualTo:  int.parse(filter.maxPopulation));
    }

    List<int> resList = [];
    if (filter.isTimeFilterEnabled) {
      resList = await filterCorporationListForReservations(filter);
    }

    var response = await list.get();
    List<CorporationModel> corpModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        bool isEliminated = false;
        Map item = list[i].data();

        CorporationModel corporationModel = CorporationModel.fromMap(item);
        if (filter.sequenceOrderUniqueIdentifier != "0" &&
            !corporationModel.sequenceOrderUniqueIdentifier.contains(filter.sequenceOrderUniqueIdentifier)) {
          isEliminated = true;
        }
        if (filter.invitationUniqueIdentifier != "0" &&
            !corporationModel.invitationUniqueIdentifier.contains(filter.invitationUniqueIdentifier)) {
          isEliminated = true;
        }
        if (filter.organizationUniqueIdentifier != "0" &&
            !corporationModel.organizationUniqueIdentifier.contains(filter.organizationUniqueIdentifier)) {
          isEliminated = true;
        }

        for (int j = 0; j < resList.length; j++) {
          if (corporationModel.corporationId == resList[j]) {
            isEliminated = true;
            break;
          }
        }
        if (!isEliminated) {
          corpModelList.add(corporationModel);
        }
      }
    }

    return corpModelList;

  }
}