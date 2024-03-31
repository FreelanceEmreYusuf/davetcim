import '../models/invitation_type_model.dart';
import '../models/organization_type_model.dart';
import '../models/sequence_order_model.dart';

class OrganizationTypeState {

  static List<OrganizationTypeModel> organizationTypeList;
  static List<InvitationTypeModel> invitationTypeList;
  static List<SequenceOrderModel> sequenceOrderList;

  static bool isOrganizationPresent() {
    return organizationTypeList != null;
  }

  static bool isInvitationPresent() {
    return invitationTypeList != null;
  }

  static bool isSequenceOrderPresent() {
    return sequenceOrderList != null;
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

  static String getOrganizationSelectionText() {
    if (organizationTypeList != null && organizationTypeList.length > 0) {
      List<OrganizationTypeModel> filteredList = organizationTypeList.where((item) => item.isChecked).toList();
      if (filteredList.length == 1)  {
        return filteredList[0].name;
      } else if (filteredList.length > 1 ) {
        return filteredList.length.toString() + " Adet Seçili";
      }
    }
    return "Seçilmemiş";
  }

  static String getInvitationSelectionText() {
    if (invitationTypeList != null && invitationTypeList.length > 0) {
      List<InvitationTypeModel> filteredList = invitationTypeList.where((item) => item.isChecked).toList();
      if (filteredList.length == 1) {
        return filteredList[0].name;
      } else if (filteredList.length > 0) {
        return filteredList.length.toString() + " Adet Seçili";
      }
    }
    return "Seçilmemiş";
  }

  static String getSequenceOrderSelectionText() {
    if (sequenceOrderList != null && sequenceOrderList.length > 0) {
      List<SequenceOrderModel> filteredList = sequenceOrderList.where((item) => item.isChecked).toList();
      if (filteredList.length == 1)  {
        return filteredList[0].name;
      } else if (filteredList.length > 0) {
        return filteredList.length.toString() + " Adet Seçili";
      }
    }
    return "Seçilmemiş";
  }

  static void setAsNull() {
    organizationTypeList = null;
    invitationTypeList = null;
    sequenceOrderList = null;
  }
}
