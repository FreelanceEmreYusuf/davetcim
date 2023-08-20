import 'package:davetcim/shared/models/district_model.dart';
import 'package:davetcim/shared/models/invitation_type_model.dart';
import 'package:davetcim/shared/models/organization_type_model.dart';
import 'package:davetcim/shared/models/region_model.dart';
import 'package:davetcim/shared/models/sequence_order_model.dart';

class FilterScreenSession {
  final List<OrganizationTypeModel> organizationTypeList;
  final List<InvitationTypeModel> invitationTypeList;
  final List<SequenceOrderModel> sequenceOrderList;
  final List<RegionModel> regionModelList;
  final List<DistrictModel> districtModelList;

  const FilterScreenSession(
      this.organizationTypeList,
      this.invitationTypeList,
      this.sequenceOrderList,
      this.regionModelList,
      this.districtModelList);
}