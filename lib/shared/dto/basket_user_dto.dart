import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/models/service_pool_model.dart';

import '../models/combo_generic_model.dart';
import '../models/corporate_sessions_model.dart';
import '../models/corporation_package_services_model.dart';
import '../models/reservation_model.dart';
import 'order_basket_dto.dart';

class BasketUserDto {
  int sessionId;
  CorporationModel corporationModel;
  int date;
  int maxPopulation;
  int totalPrice;
  List<ComboGenericModel> invitationList;
  List<ComboGenericModel> sequenceOrderList;
  List<ReservationModel> reservationList;
  CorporateSessionsModel sessionModel;
  OrderBasketDto orderBasketModel;
  CorporationPackageServicesModel packageModel;
  List<ServicePoolModel> servicePoolModel;

  BasketUserDto(
      this.sessionId,
      this.corporationModel,
      this.date,
      this.maxPopulation,
      this.totalPrice,
      this.invitationList,
      this.sequenceOrderList,
      this.reservationList,
      this.sessionModel,
      this.orderBasketModel,
      this.packageModel,
      this.servicePoolModel,
  );
}
