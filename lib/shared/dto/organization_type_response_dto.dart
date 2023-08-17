import 'package:davetcim/shared/models/company_model.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import '../models/customer_model.dart';

class OrganizationTypesResponseDto {
  Map<String, bool> organizationTypeCheckedMap;
  Map<String, int> organizationTypeNameIdMap;

  OrganizationTypesResponseDto(
      this.organizationTypeCheckedMap,
      this.organizationTypeNameIdMap,
      );
}