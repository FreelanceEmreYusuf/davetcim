class OrganizationTypesResponseDto {
  Map<String, bool> organizationTypeCheckedMap;
  Map<String, int> organizationTypeNameIdMap;

  OrganizationTypesResponseDto(
      this.organizationTypeCheckedMap,
      this.organizationTypeNameIdMap,
      );
}