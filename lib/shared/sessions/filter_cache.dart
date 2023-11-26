import 'package:davetcim/shared/models/district_model.dart';
import 'package:davetcim/shared/models/invitation_type_model.dart';
import 'package:davetcim/shared/models/organization_type_model.dart';
import 'package:davetcim/shared/models/region_model.dart';
import 'package:davetcim/shared/models/sequence_order_model.dart';

class FilterCache {
  List<OrganizationTypeModel> organizationTypeList;
  List<InvitationTypeModel> invitationTypeList;
  List<SequenceOrderModel> sequenceOrderList;
  List<RegionModel> regionModelList;

  FilterCache(
      this.organizationTypeList,
      this.invitationTypeList,
      this.sequenceOrderList,
      this.regionModelList);
}