import '../models/corporation_model.dart';

class HomeItemsState {
  static List<CorporationModel> corporationList;
  static List<CorporationModel> popularCorporationModelList;

  static bool isPresentForCorporationList() {
    return corporationList != null && corporationList.length > 0;
  }

  static bool isPresentForPopularCorporationList() {
    return popularCorporationModelList != null && popularCorporationModelList.length > 0;
  }
}