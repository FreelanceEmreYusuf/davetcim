import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/company_model.dart';
import '../../../shared/models/corporation_registration_key_model.dart';

class CorporationGenerateKeyViewModel extends ChangeNotifier {
  Database db = Database();


  Future<List<CompanyModel>> fillCompanyList() async {
    CollectionReference docsRef =
    db.getCollectionRef(DBConstants.companyDb);
    var response = await docsRef.orderBy('name').get();

    var list = response.docs;
    List<CompanyModel> companyList = [];
    list.forEach((_secretQuestion) {
      Map item = _secretQuestion.data();
      companyList.add(CompanyModel.fromMap(item));
    });

    return companyList;
  }

  Future<int> createCorporationRegistrationKey(int companyId) async {
    int id = new DateTime.now().millisecondsSinceEpoch;
    CorporationRegistrationKeyModel corpRegKeyGen = new CorporationRegistrationKeyModel(
        id: id,
        companyId: companyId,
        isActive: true,
        keyNumber: id,
        recordDate: Timestamp.now(),
        );

    db.editCollectionRef(DBConstants.corporationRegisterKeyDb, corpRegKeyGen.toMap());
    return id;
  }

}
