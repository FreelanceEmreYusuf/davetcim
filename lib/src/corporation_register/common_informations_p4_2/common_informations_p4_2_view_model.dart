import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/organization_type_response_dto.dart';
import '../../../shared/dto/service_type_response_dto.dart';

class CommonInformationsP42ViewModel extends ChangeNotifier {
  Database db = Database();

  ServiceTypesResponseDto getServiceTypes()  {
    Map<int, String> serviceSelectionMap = {};
    Map<int, bool> serviceSelectionSelectedMap = {};
    serviceSelectionMap.addAll({0: "Kullanıcı firmanın sunduğu paketleri seçebilir"});
    serviceSelectionMap.addAll({1: "Kullanıcı paketler hariç firmanın sunduğu hizmetleri seçebilir"});
    serviceSelectionSelectedMap.addAll({0: false});
    serviceSelectionSelectedMap.addAll({1: false});

    ServiceTypesResponseDto org = new ServiceTypesResponseDto(serviceSelectionMap, serviceSelectionSelectedMap);
    return org;
  }

}
