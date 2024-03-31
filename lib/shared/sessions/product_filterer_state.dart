import 'package:davetcim/shared/models/sequence_order_model.dart';

import '../dto/product_filterer_dto.dart';
import '../models/district_model.dart';
import '../models/invitation_type_model.dart';
import '../models/organization_type_model.dart';

class ProductFiltererState {
  static ProductFiltererDto filter;

  static bool isPresent() {
    return filter != null;
  }

  static void setFilter(String region,
      List<DistrictModel> districtList,
      List<InvitationTypeModel> invitationTypeList,
      List<OrganizationTypeModel> organizationTypeList,
      List<SequenceOrderModel> sequenceOrderList,
      String maxPopulation,
      bool isTimeFilterEnabled,
      DateTime date,
      DateTime startHour,
      DateTime endHour) {
      filter = ProductFiltererDto(
          region,
          districtList,
          invitationTypeList,
          organizationTypeList,
          sequenceOrderList,
          maxPopulation,
          isTimeFilterEnabled,
          date,
          startHour,
          endHour,
          false
      );
  }

  static void setSoftFilter(String region,
    List<DistrictModel> districtList,
    List<OrganizationTypeModel> organizationTypeList) {
      filter = ProductFiltererDto(
          region,
          districtList,
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