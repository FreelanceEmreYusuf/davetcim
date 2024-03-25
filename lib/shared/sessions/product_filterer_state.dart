import '../dto/product_filterer_dto.dart';

class ProductFiltererState {
  static ProductFiltererDto filter;

  static bool isPresent() {
    return filter != null;
  }

  static void setFilter(String region, String district,
      String invitationUniqueIdentifier,
      String organizationUniqueIdentifier,
      String sequenceOrderUniqueIdentifier,
      String maxPopulation,
      bool isTimeFilterEnabled,
      DateTime date,
      DateTime startHour,
      DateTime endHour) {
      filter = ProductFiltererDto(
          region,
          district,
          invitationUniqueIdentifier,
          organizationUniqueIdentifier,
          sequenceOrderUniqueIdentifier,
          maxPopulation,
          isTimeFilterEnabled,
          date,
          startHour,
          endHour,
          false
      );
  }

  static void setSoftFilter(String region, String district,
      String organizationUniqueIdentifier) {
      filter = ProductFiltererDto(
          region,
          district,
          null,
          organizationUniqueIdentifier,
          null,
          "0",
          false,
          null,
          null,
          null,
          true
      );
  }

  static void setAsNull() {
    filter = null;
  }
}