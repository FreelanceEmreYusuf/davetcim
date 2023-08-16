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

class ReservationCorporateViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ReservationModel>> getReservationlist(int corporateId) async {
    var response = await db
        .getCollectionRef("CorporationReservations")
        .where('corporationId', isEqualTo: corporateId)
        .where('isActive', isEqualTo: true)
        .where('date', isGreaterThanOrEqualTo: DateConversionUtils.getTodayAsInt())
        .where('reservationStatus', whereIn: ReservationStatusEnumConverter.adminViewedReservationStatus())
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

  Future<ReservationDetailViewDto> getReservationDetail(ReservationModel model) async {
    ReservationDetailViewDto rdvm = ReservationDetailViewDto();

    var response = await db
        .getCollectionRef("ReservationDetail")
        .where('reservationId', isEqualTo: model.id)
        .get();

    List<ReservationDetailModel> detailList = [];

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      List<int> selectedServicesIds = [];
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ReservationDetailModel detailModel = ReservationDetailModel.fromMap(item);
        selectedServicesIds.add(detailModel.foreignId);
      }

      List<ServicePoolModel> serviceList = await getServicePoolModelList(selectedServicesIds);
      List<ServiceCorporatePoolModel> serviceCorporateList = await getServicePoolCorporateModelList(selectedServicesIds, model);

      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ReservationDetailModel detailModel = ReservationDetailModel.fromMap(item);
        detailModel.servicePoolModel = await getServicePoolModel(serviceList, detailModel, serviceCorporateList);
        detailList.add(detailModel);
      }
    }

    rdvm.reservationModel = model;
    rdvm.detailList = detailList;

    CorporateSessionsViewModel csvm = CorporateSessionsViewModel();
    rdvm.sessionModel = await csvm.getSession(model.sessionId);

    CustomerHelper custHelper = CustomerHelper();
    rdvm.customerModel = await custHelper.getCustomer(rdvm.reservationModel.customerId);

    return rdvm;
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
    Map reservationMap = model.toMap();
    isApproved ?
        reservationMap["reservationStatus"] = ReservationStatusEnum.approved.index :
        reservationMap["reservationStatus"] = ReservationStatusEnum.adminRejected.index;

    reservationMap["isActive"] = isApproved;
    db.editCollectionRef(DBConstants.corporationReservationsDb, reservationMap);
  }


}