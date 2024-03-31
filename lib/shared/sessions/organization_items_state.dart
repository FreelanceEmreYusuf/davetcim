import 'package:davetcim/shared/models/invitation_type_model.dart';
import 'package:davetcim/shared/models/organization_type_model.dart';
import 'package:davetcim/shared/models/region_model.dart';
import 'package:davetcim/shared/models/sequence_order_model.dart';

class OrganizationItemsState {
  static List<OrganizationTypeModel> organizationTypeList;
  static List<InvitationTypeModel> invitationTypeList;
  static List<SequenceOrderModel> sequenceOrderList;
  static List<RegionModel> regionModelList;

  static bool isPresent() {
    return regionModelList != null && regionModelList.length > 0;
  }

  static void set(List<OrganizationTypeModel> organizationTypeListParam,
      List<InvitationTypeModel> invitationTypeListParam,
      List<SequenceOrderModel> sequenceOrderListParam,
      List<RegionModel> regionModelListParam) {

    organizationTypeList = organizationTypeListParam;
    invitationTypeList = invitationTypeListParam;
    sequenceOrderList = sequenceOrderListParam;
    regionModelList = regionModelListParam;

    invitationTypeListParam = null;
    invitationTypeListParam = null;
    sequenceOrderListParam = null;
    regionModelListParam = null;
  }

  static void resetItems() {
    for(int i = 0; i < organizationTypeList.length; i++)  {
      organizationTypeList[i].isChecked = false;
    }
    for(int i = 0; i < invitationTypeList.length; i++)  {
      invitationTypeList[i].isChecked = false;
    }
    for(int i = 0; i < sequenceOrderList.length; i++)  {
      sequenceOrderList[i].isChecked = false;
    }
  }
}