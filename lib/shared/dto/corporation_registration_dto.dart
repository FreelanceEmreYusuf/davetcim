import 'package:davetcim/shared/models/company_model.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import '../models/customer_model.dart';

class CorporationReservationDto {
  CompanyModel companyModel;
  CorporationModel corporationModel;
  CustomerModel customerModel;

  CorporationReservationDto(
      this.companyModel,
      this.corporationModel,
      this.customerModel,
  );
}