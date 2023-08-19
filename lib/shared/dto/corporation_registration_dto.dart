import 'package:davetcim/shared/models/company_model.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import '../models/customer_model.dart';

class CorporationReservationDto {
  CompanyModel companyModel;
  CorporationModel corporationModel;
  CustomerModel customerModel;
  String regionName;
  String districtName;
  String organizationTypes;
  String invitationTypes;
  String sequenceOrderTypes;
  String secretQuestionName;
  int registrationKey;

  CorporationReservationDto(
      this.companyModel,
      this.corporationModel,
      this.customerModel,
      this.regionName,
      this.districtName,
      this.organizationTypes,
      this.invitationTypes,
      this.sequenceOrderTypes,
      this.secretQuestionName,
      this.registrationKey
  );
}