import 'package:davetcim/shared/models/service_pool_model.dart';

import '../models/combo_generic_model.dart';
import '../models/corporate_sessions_model.dart';
import '../models/reservation_model.dart';
import 'order_basket_model.dart';

class BasketUserModel {
  int sessionId;
  int corporationId;
  int date;
  List<ComboGenericModel> invitationList;
  List<ComboGenericModel> sequenceOrderList;
  List<ReservationModel> reservationList;
  CorporateSessionsModel sessionModel;
  OrderBasketModel orderBasketModel;
  List<ServicePoolModel> servicePoolModel;


  BasketUserModel(
      this.sessionId,
      this.corporationId,
      this.date,
      this.invitationList,
      this.sequenceOrderList,
      this.reservationList,
      this.sessionModel,
      this.orderBasketModel,
      this.servicePoolModel,
  );
}
