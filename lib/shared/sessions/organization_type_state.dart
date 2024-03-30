import '../models/organization_type_model.dart';

class OrganizationTypeState {

  static List<OrganizationTypeModel> organizationTypeList;

  static bool isPresent() {
    return organizationTypeList != null;
  }

  static void set(List<OrganizationTypeModel> organizationTypeParamList) {
    organizationTypeList = organizationTypeParamList;
  }

  static void setAsNull() {
    organizationTypeList = null;
  }
}
