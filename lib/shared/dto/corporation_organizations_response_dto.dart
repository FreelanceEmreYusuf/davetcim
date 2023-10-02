import 'package:davetcim/shared/dto/service_type_response_dto.dart';

import 'organization_type_response_dto.dart';

class CorporationOrganizationsResponseDto {
  OrganizationTypesResponseDto organizationTypeResponse;
  OrganizationTypesResponseDto sequenceOrderResponse;
  OrganizationTypesResponseDto invitationTypeResponse;
  ServiceTypesResponseDto serviceTypeResponse;

  CorporationOrganizationsResponseDto(
      this.organizationTypeResponse,
      this.sequenceOrderResponse,
      this.invitationTypeResponse,
      this.serviceTypeResponse
      );
}