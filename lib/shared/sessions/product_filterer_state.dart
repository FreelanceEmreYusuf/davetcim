import '../dto/product_filterer_dto.dart';
import '../models/organization_type_model.dart';

class ProductFiltererState {
  static ProductFiltererDto filter;

  static bool isPresent() {
    return filter != null;
  }

  static void setFilter(String region, String district,
      String invitationUniqueIdentifier,
      List<OrganizationTypeModel> organizationTypeList,
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
          organizationTypeList,
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
    List<OrganizationTypeModel> organizationTypeList) {
      filter = ProductFiltererDto(
          region,
          district,
          null,
          organizationTypeList,
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