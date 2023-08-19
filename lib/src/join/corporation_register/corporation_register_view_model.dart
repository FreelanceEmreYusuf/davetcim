import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/helpers/customer_helper.dart';
import 'package:davetcim/shared/models/company_model.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/admin_panel/company/company_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/enums/customer_role_enum.dart';
import '../../../shared/models/corporation_registration_key_model.dart';
import '../join_view.dart';

class CorporationRegisterViewModel extends ChangeNotifier {
  Database db = Database();

  Future<CompanyModel> getCompanyForKey(int keyNumber) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationRegisterKeyDb)
        .where('keyNumber', isEqualTo:keyNumber)
        .where('isActive', isEqualTo:true)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      CorporationRegistrationKeyModel keyModel = CorporationRegistrationKeyModel.fromMap(list[0].data());
      CompanyViewModel cvm = CompanyViewModel();
      CompanyModel companyModel = await cvm.getById(keyModel.companyId);
      return companyModel;

    } else {
      return null;
    }
  }




}
