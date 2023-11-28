import 'dart:math';

import 'package:davetcim/shared/models/corporation_package_services_model.dart';
import 'package:davetcim/shared/models/service_pool_model.dart';

import '../models/combo_generic_model.dart';
import '../models/corporate_sessions_model.dart';
import '../models/corporation_model.dart';
import '../models/customer_model.dart';
import '../models/reservation_detail_model.dart';
import '../models/reservation_model.dart';
import 'order_basket_dto.dart';

class ReservationDetailViewDto {
  ReservationModel reservationModel;
  List<ReservationDetailModel> detailList;
  CorporationPackageServicesModel packageModel;
  CustomerModel customerModel;
  CorporationModel corporateModel;
  CorporateSessionsModel selectedSessionModel;
  List<ComboGenericModel> invitationList;
  List<ComboGenericModel> sequenceOrderList;
  OrderBasketDto orderBasketModel;
  List<ServicePoolModel> servicePoolModel;


  ReservationDetailViewDto({
    this.reservationModel,
    this.detailList,
    this.packageModel,
    this.customerModel,
    this.corporateModel,
    this.selectedSessionModel,
    this.invitationList,
    this.sequenceOrderList,
    this.orderBasketModel,
    this.servicePoolModel
  });


}
