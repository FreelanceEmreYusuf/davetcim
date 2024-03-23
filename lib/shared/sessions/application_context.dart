import 'package:davetcim/shared/sessions/reservation_detail_view_dto.dart';
import 'package:davetcim/shared/sessions/user_cache.dart';
import 'basket_user_dto.dart';
import 'corporation_registration_dto.dart';
import 'filter_cache.dart';

class ApplicationContext {
  static UserCache userCache;
  static int notificationCount;
  static int basketCount;
  static FilterCache filterCache;
  static List<int> favoriteCorporationList;
  static BasketUserDto userBasket;
  static CorporationReservationDto corporationReservation;
  static ReservationDetailViewDto reservationDetail;

  static bool isCorporationFavorite(int corporationId) {
    if (userCache == null) {
      return false;
    }
    if (favoriteCorporationList == null) {
      return false;
    }
    for (int i = 0; i < favoriteCorporationList.length; i++) {
      if (corporationId == favoriteCorporationList[i]) {
        return true;
      }
    }
    return false;
  }
}