import '../models/organization_type_model.dart';

class ProductFiltererDto {
  final String region;
  final String district;
  final String invitationUniqueIdentifier;
  final List<OrganizationTypeModel> organizationTypeList;
  final String sequenceOrderUniqueIdentifier;
  final String maxPopulation;
  final bool isTimeFilterEnabled;
  final DateTime date;
  final DateTime startHour;
  final DateTime endHour;
  final bool isSoftFilter;

  const ProductFiltererDto(
      this.region,
      this.district,
      this.invitationUniqueIdentifier,
      this.organizationTypeList,
      this.sequenceOrderUniqueIdentifier,
      this.maxPopulation,
      this.isTimeFilterEnabled,
      this.date,
      this.startHour,
      this.endHour,
      this.isSoftFilter
      );
}
