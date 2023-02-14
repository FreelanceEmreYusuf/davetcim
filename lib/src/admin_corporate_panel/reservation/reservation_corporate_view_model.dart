import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/service_corporate_pool_model.dart';
import 'package:davetcim/shared/models/service_pool_model.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/dto/reservation_detail_view_model.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/services/database.dart';
import '../seans/seans_corporate_view_model.dart';

class ReservationCorporateViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ReservationModel>> getReservationlist(int corporateId) async {
    var response = await db
        .getCollectionRef("CorporationReservations")
        .where('corporationId', isEqualTo: corporateId)
        .where('isActive', isEqualTo: true)
        .where('isMoneyTransfered', isEqualTo: false)
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

  Future<ReservationDetailViewModel> getReservationDetail(ReservationModel model) async {
    ReservationDetailViewModel rdvm = ReservationDetailViewModel();


    var response = await db
        .getCollectionRef("ReservationDetail")
        .where('reservationId', isEqualTo: model.id)
        .get();

    List<ReservationDetailModel> detailList = [];

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ReservationDetailModel detailModel = ReservationDetailModel.fromMap(item);
        detailModel.servicePoolModel = await getServicePoolModel(detailModel, model);
        detailList.add(detailModel);
      }
    }

    rdvm.reservationModel = model;
    rdvm.detailList = detailList;

    CorporateSessionsViewModel csvm = CorporateSessionsViewModel();
    rdvm.sessionModel = await csvm.getSession(model.sessionId);

    return rdvm;
  }

  Future<ServicePoolModel> getServicePoolModel(ReservationDetailModel reservationDetailModel, ReservationModel model) async {
    if (reservationDetailModel.foreignType != "service") {
      return null;
    }

    var response = await db
        .getCollectionRef(DBConstants.servicesDb)
        .where('id', isEqualTo: reservationDetailModel.foreignId)
        .where('isActive', isEqualTo: true)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      ServicePoolModel serviceModel = ServicePoolModel.fromMap(item);
      serviceModel.corporateDetail = await getServicePoolCorporateModel(serviceModel, model);
      return serviceModel;
    }

    return null;
  }

  Future<ServiceCorporatePoolModel> getServicePoolCorporateModel(ServicePoolModel servicePoolModel, ReservationModel model) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationServicesDb)
        .where('serviceId', isEqualTo: servicePoolModel.id)
        .where('corporateId', isEqualTo: model.corporationId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      ServiceCorporatePoolModel serviceCorpModel = ServiceCorporatePoolModel.fromMap(item);
      return serviceCorpModel;
    }

    return null;
  }


}