import 'package:davetcim/shared/dto/user_session.dart';

import 'filter_screen_session.dart';

class ApplicationSession {
  static UserSession userSession;
  static int notificationCount;
  static int basketCount;
  static FilterScreenSession filterScreenSession;
  static List<int> favoriteCorporationList;

  static bool isCorporationFavorite(int corporationId) {
    if (userSession == null) {
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