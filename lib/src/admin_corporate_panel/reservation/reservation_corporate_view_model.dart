import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/models/service_corporate_pool_model.dart';
import 'package:davetcim/shared/models/service_pool_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/enums/reservation_status_enum.dart';
import '../../../shared/environments/const.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/services/database.dart';
import '../../../shared/utils/date_utils.dart';

class ReservationCorporateViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ReservationModel>> getReservationlist(int corporateId) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('corporationId', isEqualTo: corporateId)
        .where('isActive', isEqualTo: true)
        .where('date', isGreaterThanOrEqualTo: DateConversionUtils.getTodayAsInt())
        .where('reservationStatus', whereIn: ReservationStatusEnumConverter.adminViewedReservationStatus())
        .orderBy('date', descending: true)
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

  Stream<List<ReservationModel>> getOnlineReservationlist(int corporateId) {
    Stream<List<DocumentSnapshot>> reservationStreamList =  db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('corporationId', isEqualTo: corporateId)
        .where('isActive', isEqualTo: true)
        .where('date', isGreaterThanOrEqualTo: DateConversionUtils.getTodayAsInt())
        .where('reservationStatus', whereIn: ReservationStatusEnumConverter.adminViewedReservationStatus())
        .orderBy('date', descending: true)
        .snapshots()
        .map((event) => event.docs);

    Stream<List<ReservationModel>> reservationList = reservationStreamList
        .map((event) => event.map((e) => ReservationModel.fromMap(e.data())).toList());

    return reservationList;
  }

  Future<List<ServicePoolModel>> getServicePoolModelList(List<int> selectedServicesIds) async {
    List<ServicePoolModel> serviceList = [];

    var response = await db
        .getCollectionRef(DBConstants.servicesDb)
        .where('id', whereIn: selectedServicesIds)
        .where('isActive', isEqualTo: true)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ServicePoolModel serviceModel = ServicePoolModel.fromMap(item);
        serviceList.add(serviceModel);
      }
    }

    return serviceList;
  }

  Future<List<ServicePoolModel>> getServicePoolModelDetailedList(List<int> selectedServicesIds, ReservationModel model) async {
    List<ServicePoolModel> serviceList = [];
    List<ServiceCorporatePoolModel> corporateServiceList = await getServicePoolCorporateModelList(selectedServicesIds, model);

    var response = await db
        .getCollectionRef(DBConstants.servicesDb)
        .where('id', whereIn: selectedServicesIds)
        .where('isActive', isEqualTo: true)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ServicePoolModel serviceModel = ServicePoolModel.fromMap(item);
        for (int j = 0; j < corporateServiceList.length; j++) {
          ServiceCorporatePoolModel model = corporateServiceList[j];
          serviceModel.companyHasService = false;
          serviceModel.hasChild = false;
          if (model.serviceId == serviceModel.id) {
            serviceModel.corporateDetail = model;
            serviceModel.companyHasService = true;
            break;
          }
        }
        serviceList.add(serviceModel);
      }
    }

    return serviceList;
  }


  Future<ServicePoolModel> getServicePoolModel(List<ServicePoolModel> serviceList, ReservationDetailModel reservationDetailModel,
      List<ServiceCorporatePoolModel> serviceCorporateList) async {
    for (int i = 0; i < serviceList.length; i++) {
      ServicePoolModel item = serviceList[i];
      if (item.id == reservationDetailModel.foreignId) {
        for (int j = 0; j < serviceCorporateList.length; j++) {
          ServiceCorporatePoolModel serviceCorporatePoolModel = serviceCorporateList[j];
          if (item.id == serviceCorporatePoolModel.serviceId) {
            item.corporateDetail = serviceCorporatePoolModel;
            break;
          }
        }
        return item;
      }
    }
    return null;
  }

  Future<List<ServiceCorporatePoolModel>> getServicePoolCorporateModelList(List<int> selectedServicesIds, ReservationModel model) async {
    List<ServiceCorporatePoolModel> serviceCorporateList = [];
    var response = await db
        .getCollectionRef(DBConstants.corporationServicesDb)
        .where('serviceId', whereIn: selectedServicesIds)
        .where('corporateId', isEqualTo: model.corporationId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ServiceCorporatePoolModel serviceCorporateModel = ServiceCorporatePoolModel.fromMap(item);
        serviceCorporateList.add(serviceCorporateModel);
      }
    }

    return serviceCorporateList;
  }

  Future<void> editReservationForAdmin(ReservationModel model, bool isApproved) async {
    if (isApproved) {
      if (model.reservationStatus == ReservationStatusEnum.userOffer) {
        model.reservationStatus =  ReservationStatusEnum.preReservation;
      } else  if (model.reservationStatus == ReservationStatusEnum.preReservation) {
        model.reservationStatus = ReservationStatusEnum.reservation;
        CorporateHelper corporateHelper = CorporateHelper();
        CorporationModel corporateModel = await corporateHelper.getCorporate(model.corporationId);
        corporateModel.point = corporateModel.point +
            Constants.reservationAdditionPoint;
        db.editCollectionRef(DBConstants.corporationDb, corporateModel.toMap());
      }
    } else {
      if (model.reservationStatus == ReservationStatusEnum.reservation) {
        model.reservationStatus = ReservationStatusEnum.preReservation;
        CorporateHelper corporateHelper = CorporateHelper();
        CorporationModel corporateModel = await corporateHelper.getCorporate(model.corporationId);
        corporateModel.point = corporateModel.point -
            Constants.reservationAdditionPoint;
        db.editCollectionRef(DBConstants.corporationDb, corporateModel.toMap());
      } else if (model.reservationStatus == ReservationStatusEnum.preReservation) {
        model.reservationStatus = ReservationStatusEnum.userOffer;
      } else {
        model.reservationStatus =  ReservationStatusEnum.adminRejectedOffer;
        model.isActive = isApproved;
      }
    }

    model.version = model.version + 1;
    db.editCollectionRef(DBConstants.corporationReservationsDb, model.toMap());
  }
}