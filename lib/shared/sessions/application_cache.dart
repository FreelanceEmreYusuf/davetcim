import 'package:davetcim/shared/sessions/user_cache.dart';
import 'filter_cache.dart';

class ApplicationCache {
  static UserCache userCache;
  static int notificationCount;
  static int basketCount;
  static FilterCache filterCache;
  static List<int> favoriteCorporationList;

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