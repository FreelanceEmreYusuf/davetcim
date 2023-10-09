import 'dart:math';

import 'package:davetcim/shared/models/corporation_package_services_model.dart';
import 'package:davetcim/shared/models/service_pool_model.dart';

import '../models/corporate_sessions_model.dart';
import '../models/corporation_model.dart';
import '../models/customer_model.dart';
import '../models/reservation_detail_model.dart';
import '../models/reservation_model.dart';

class ReservationDetailViewDto {
  ReservationModel reservationModel;
  List<ReservationDetailModel> detailList;
  CorporationPackageServicesModel packageModel;
  CorporateSessionsModel sessionModel;
  CustomerModel customerModel;
  CorporationModel corporateModel;

  ReservationDetailViewDto({
    this.reservationModel,
    this.detailList,
    this.packageModel,
    this.sessionModel,
    this.customerModel,
    this.corporateModel,
  });


}
