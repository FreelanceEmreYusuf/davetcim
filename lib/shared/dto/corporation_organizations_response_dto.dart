import 'organization_type_response_dto.dart';

class CorporationOrganizationsResponseDto {
  OrganizationTypesResponseDto organizationTypeResponse;
  OrganizationTypesResponseDto sequenceOrderResponse;
  OrganizationTypesResponseDto invitationTypeResponse;

  CorporationOrganizationsResponseDto(
      this.organizationTypeResponse,
      this.sequenceOrderResponse,
      this.invitationTypeResponse,
      );
}