import '../models/corporation_model.dart';

class ProductsViewState {
  static List<CorporationModel> corporationList;
  static int currentPage;
  static int lastViewedPoint;
  static int pagingSize;

  static bool isPresent() {
    return corporationList != null;
  }

  static void set(List<CorporationModel> corporationParamList, int pagingParamSize) async {
    corporationList = corporationParamList;
    currentPage = 1;
    lastViewedPoint = 0;
    pagingSize = pagingParamSize;
  }

  static List<CorporationModel> getNextList() {
    List<CorporationModel> corporationNextList =
      corporationList.where((item) => item.sortingIndex > lastViewedPoint &&
          item.sortingIndex <= lastViewedPoint + pagingSize).toList();
    lastViewedPoint = lastViewedPoint + pagingSize;
    return corporationNextList;
  }

  static void setAsNull() {
    corporationList = null;
    currentPage = null;
    lastViewedPoint = null;
    pagingSize = null;
  }
}