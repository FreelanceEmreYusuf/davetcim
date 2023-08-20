import 'package:davetcim/shared/dto/user_session_dto.dart';
import 'package:davetcim/shared/models/district_model.dart';

import '../models/region_model.dart';
import 'filter_screen_session.dart';

class ApplicationSession {
  static UserSessionDto userSession;
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

  static List<DistrictModel> getDistrictList(int regionCode) {
    List<DistrictModel> responseList = [];
    for (int i = 0; i < filterScreenSession.districtModelList.length; i++) {
      DistrictModel districtModel = filterScreenSession.districtModelList[i];
      if (districtModel.regionId == regionCode) {
        responseList.add(districtModel);
      }
    }
    return responseList;
  }

}