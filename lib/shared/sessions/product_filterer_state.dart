import 'package:davetcim/shared/models/sequence_order_model.dart';

import '../dto/product_filterer_dto.dart';
import '../models/invitation_type_model.dart';
import '../models/organization_type_model.dart';

class ProductFiltererState {
  static ProductFiltererDto filter;

  static bool isPresent() {
    return filter != null;
  }

  static void setFilter(String region, String district,
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
          district,
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