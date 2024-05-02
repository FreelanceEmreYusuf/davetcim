import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/models/service_corporate_pool_model.dart';
import 'package:davetcim/shared/models/service_pool_model.dart';
import 'package:davetcim/shared/sessions/user_state.dart';
import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/dto/reservation_detail_view_dto.dart';
import '../../../shared/enums/reservation_status_enum.dart';
import '../../../shared/helpers/customer_helper.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/services/database.dart';
import '../../shared/models/corporation_model.dart';
import '../../shared/models/corporation_package_services_model.dart';

class UserReservationsViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ReservationModel>> getReservationlist() async {
    var response = await db
        .getCollectionRef("CorporationReservations")
        .where('customerId', isEqualTo: UserState.id)
        .where('reservationStatus', whereIn: ReservationStatusEnumConverter.userViewedReservationStatus()) 
        .orderBy('recordDate', descending: true)
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
        .getCollectionRef(DBConstants.reservationDetailDb)
        .where('reservationId', isEqualTo: model.id)
        .get();

    List<ReservationDetailModel> detailList = [];

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;

      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ReservationDetailModel detailModel = ReservationDetailModel.fromMap(item);
        if (detailModel.foreignType == "package") {
          CorporationPackageServicesModel packageServicesModel = CorporationPackageServicesModel(
            id: 1,
            corporateId: model.corporationId,
            title: detailModel.serviceName,
            body: detailModel.serviceBody,
            price: detailModel.price,
            isActive: true,
            createIntDate: DateConversionUtils.getTodayAsInt(),
            createDate: Timestamp.now()
          );

          rdvm.packageModel = packageServicesModel;
        } else if (detailModel.foreignType == "service") {
          detailList.add(detailModel);
        }
      }
    }

    rdvm.reservationModel = model;
    rdvm.detailList = detailList;

    CustomerHelper custHelper = CustomerHelper();
    rdvm.customerModel = await custHelper.getCustomer(rdvm.reservationModel.customerId);

    CorporateHelper corporateHelper = CorporateHelper();
    CorporationModel corporateModel = await corporateHelper.getCorporate(rdvm.reservationModel.corporationId);
    rdvm.corporateModel = corporateModel;

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

  Future<void> rejectReservationForUser(ReservationModel model) async {
    Map reservationMap = model.toMap();
    reservationMap["reservationStatus"] = ReservationStatusEnum.userRejectedOffer.index;
    reservationMap["isActive"] = false;
    db.editCollectionRef(DBConstants.corporationReservationsDb, reservationMap);
  }
}