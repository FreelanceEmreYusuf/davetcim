import '../models/district_model.dart';
import '../models/invitation_type_model.dart';
import '../models/organization_type_model.dart';
import '../models/sequence_order_model.dart';

class OrganizationTypeState {

  static List<OrganizationTypeModel> organizationTypeList;
  static List<InvitationTypeModel> invitationTypeList;
  static List<SequenceOrderModel> sequenceOrderList;
  static List<DistrictModel> districtList;

  static bool isOrganizationPresent() {
    return organizationTypeList != null;
  }

  static bool isInvitationPresent() {
    return invitationTypeList != null;
  }

  static bool isSequenceOrderPresent() {
    return sequenceOrderList != null;
  }

  static bool isDistrictPresent() {
    return districtList != null;
  }

  static void setOrganization(List<OrganizationTypeModel> organizationTypeParamList) {
    organizationTypeList = organizationTypeParamList;
  }

  static void setInvitation(List<InvitationTypeModel> invitationTypeParamList) {
    invitationTypeList = invitationTypeParamList;
  }

  static void setSequenceOrder(List<SequenceOrderModel> sequenceOrderParamList) {
    sequenceOrderList = sequenceOrderParamList;
  }

  static void setDistrict(List<DistrictModel> districtParamList) {
    districtList = districtParamList;
  }

  static String getOrganizationSelectionText() {
    if (organizationTypeList != null && organizationTypeList.length > 0) {
      List<OrganizationTypeModel> filteredList = organizationTypeList.where((item) => item.isChecked).toList();
      if (filteredList.length == 1)  {
        return filteredList[0].name;
      } else if (filteredList.length > 1 ) {
        return "Seçili ("+filteredList.length.toString() + " Adet)";
      }
    }
    return "Seçiniz";
  }

  static String getInvitationSelectionText() {
    if (invitationTypeList != null && invitationTypeList.length > 0) {
      List<InvitationTypeModel> filteredList = invitationTypeList.where((item) => item.isChecked).toList();
      if (filteredList.length == 1) {
        return filteredList[0].name;
      } else if (filteredList.length > 0) {
        return "Seçili ("+filteredList.length.toString() + " Adet)";

      }
    }
    return "Seçiniz";
  }

  static String getSequenceOrderSelectionText() {
    if (sequenceOrderList != null && sequenceOrderList.length > 0) {
      List<SequenceOrderModel> filteredList = sequenceOrderList.where((item) => item.isChecked).toList();
      if (filteredList.length == 1)  {
        return filteredList[0].name;
      } else if (filteredList.length > 0) {
        return "Seçili ("+filteredList.length.toString() + " Adet)";
      }
    }
    return "Seçiniz";
  }

  static String getDistrictSelectionText() {
    if (districtList != null && districtList.length > 0) {
      List<DistrictModel> filteredList = districtList.where((item) => item.isChecked).toList();
      if (filteredList.length == 1)  {
        return filteredList[0].name;
      } else if (filteredList.length > 0) {
        return "Seçili ("+filteredList.length.toString() + " Adet)";
      }
    }
    return "Seçiniz";
  }

  static void setAsNull() {
    organizationTypeList = null;
    invitationTypeList = null;
    sequenceOrderList = null;
    districtList = null;
  }
}
