import 'dart:math';

import 'package:davetcim/shared/models/service_pool_model.dart';

import '../models/corporate_sessions_model.dart';
import '../models/reservation_detail_model.dart';
import '../models/reservation_model.dart';

class ReservationDetailViewModel {
  ReservationModel reservationModel;
  List<ReservationDetailModel> detailList;
  CorporateSessionsModel sessionModel;

  ReservationDetailViewModel({
    this.reservationModel,
    this.detailList,
    this.sessionModel,
  });


}
