class ServiceTypesResponseDto {
  Map<int, String> serviceTypeTitleMap;
  Map<int, bool> serviceTypeChecked;

  ServiceTypesResponseDto(
      this.serviceTypeTitleMap,
      this.serviceTypeChecked,
      );
}