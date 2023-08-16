import 'package:davetcim/shared/models/service_pool_model.dart';

import '../models/combo_generic_model.dart';
import '../models/corporate_sessions_model.dart';
import '../models/reservation_model.dart';
import 'order_basket_dto.dart';

class CorporationReservationDto {
  int sessionId;
  int corporationId;
  int date;
  int maxPopulation;
  int totalPrice;
  List<ComboGenericModel> invitationList;
  List<ComboGenericModel> sequenceOrderList;
  List<ReservationModel> reservationList;
  CorporateSessionsModel sessionModel;
  CorporateSessionsModel selectedSessionModel;
  OrderBasketDto orderBasketModel;
  List<ServicePoolModel> servicePoolModel;


  CorporationReservationDto(
      this.sessionId,
      this.corporationId,
      this.date,
      this.maxPopulation,
      this.totalPrice,
      this.invitationList,
      this.sequenceOrderList,
      this.reservationList,
      this.sessionModel,
      this.orderBasketModel,
      this.servicePoolModel,
      );
}