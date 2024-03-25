import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/helpers/customer_helper.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_context.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/corporation_registration_dto.dart';
import '../../../shared/enums/customer_role_enum.dart';
import '../../../shared/models/corporation_registration_key_model.dart';
import '../../admin_panel/corporation/corporation_generate_key_view_model.dart';
import '../../main/main_screen_view.dart';

class CommonInformationsP6ViewModel extends ChangeNotifier {
  Database db = Database();

  Future<void> corporationRegisterFlow(
      BuildContext context) async {
      db.editCollectionRef(DBConstants.corporationDb,
          ApplicationContext.corporationReservation.corporationModel.toMap());
      db.editCollectionRef(DBConstants.customerDB,
          ApplicationContext.corporationReservation.customerModel.toMap());

      CorporationGenerateKeyViewModel cgvm = CorporationGenerateKeyViewModel();
      CorporationRegistrationKeyModel keyModel = await cgvm.getByKeyNo(
          ApplicationContext.corporationReservation.registrationKey);
      Map items = keyModel.toMap();
      items["isActive"] = false;
      db.editCollectionRef(DBConstants.corporationRegisterKeyDb, items);
      Utils.navigateToPage(context, MainScreen());
  }
}
