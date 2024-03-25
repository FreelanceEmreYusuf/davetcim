import 'package:davetcim/shared/models/company_model.dart';

import '../dto/corporation_registration_dto.dart';
import '../models/corporation_model.dart';

class CorporationRegistrationState {
  static CorporationReservationDto corporationReservation;

  static bool isPresent() {
    return corporationReservation != null;
  }

  static void set(CompanyModel companyModel,
      CorporationModel corporationModel, String regionName, String districtName,
      int registrationKey) {
    corporationReservation = CorporationReservationDto(companyModel,
        corporationModel, null, regionName, districtName, "", "", "", "",
        registrationKey);
  }

  static void setAsNull() {
    corporationReservation = null;
  }
}