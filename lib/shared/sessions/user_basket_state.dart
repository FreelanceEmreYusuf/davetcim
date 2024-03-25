import '../dto/basket_user_dto.dart';
import '../models/combo_generic_model.dart';
import '../models/corporation_model.dart';
import '../models/reservation_model.dart';
import '../models/service_pool_model.dart';

class UserBasketState {
  static List<ServicePoolModel> servicePoolModel;
  static BasketUserDto userBasket;

  static bool isPresent() {
    return userBasket != null;
  }

  static void set(CorporationModel corporationModel,
      List<ComboGenericModel> sequenceOrderList,
      List<ComboGenericModel> invitationList,
      List<ReservationModel> reservationList) {

    servicePoolModel = [];
    userBasket = BasketUserDto(
        0, corporationModel, 0, corporationModel.maxPopulation,
        0, invitationList,
        sequenceOrderList, reservationList,
        null, null, null, null);
  }

  static void setAsNull() {
    servicePoolModel = null;
    userBasket = null;
  }
}