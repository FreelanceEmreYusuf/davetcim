import 'package:davetcim/shared/models/district_model.dart';
import 'package:davetcim/shared/models/invitation_type_model.dart';
import 'package:davetcim/shared/models/organization_type_model.dart';
import 'package:davetcim/shared/models/region_model.dart';
import 'package:davetcim/shared/models/sequence_order_model.dart';

class FilterScreenSession {
  List<OrganizationTypeModel> organizationTypeList;
  List<InvitationTypeModel> invitationTypeList;
  List<SequenceOrderModel> sequenceOrderList;
  List<RegionModel> regionModelList;
  List<DistrictModel> districtModelList;

  FilterScreenSession(
      this.organizationTypeList,
      this.invitationTypeList,
      this.sequenceOrderList,
      this.regionModelList,
      this.districtModelList);
}