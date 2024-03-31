import 'package:davetcim/shared/models/sequence_order_model.dart';
import 'package:davetcim/widgets/filter_items/sequence_order_modal_content.dart';

import '../models/invitation_type_model.dart';
import '../models/organization_type_model.dart';

class ProductFiltererDto {
  final String region;
  final String district;
  final List<InvitationTypeModel> invitationTypeList;
  final List<OrganizationTypeModel> organizationTypeList;
  final List<SequenceOrderModel> sequenceOrderList;
  final String maxPopulation;
  final bool isTimeFilterEnabled;
  final DateTime date;
  final DateTime startHour;
  final DateTime endHour;
  final bool isSoftFilter;

  const ProductFiltererDto(
      this.region,
      this.district,
      this.invitationTypeList,
      this.organizationTypeList,
      this.sequenceOrderList,
      this.maxPopulation,
      this.isTimeFilterEnabled,
      this.date,
      this.startHour,
      this.endHour,
      this.isSoftFilter
      );
}
