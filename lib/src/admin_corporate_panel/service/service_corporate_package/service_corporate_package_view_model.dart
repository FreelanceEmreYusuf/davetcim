import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/models/corporation_package_services_model.dart';
import '../../../../shared/utils/date_utils.dart';


class ServiceCorporatePackageViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<CorporationPackageServicesModel>> getPackageList(int corporateId) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationServicesDb)
        .where('corporateId', isEqualTo: corporateId)
        .where('isActive', isEqualTo: true)
        .get();

    List<CorporationPackageServicesModel> packagesList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < response.docs.length; i++) {
        CorporationPackageServicesModel model = CorporationPackageServicesModel
            .fromMap(list[i].data());
        packagesList.add(model);
      }
    }

    return packagesList;
  }

  Future<void> addPackageItem(String title, String body,  int price) {
    CorporationPackageServicesModel model = new CorporationPackageServicesModel(
        id: new DateTime.now().millisecondsSinceEpoch,
        createDate: Timestamp.now(),
        createIntDate: DateConversionUtils.getTodayAsInt(),
        corporateId: ApplicationSession.userSession.corporationId,
        title : title,
        body: body,
        price: price,
        isActive: true);

    db.editCollectionRef(DBConstants.corporationServicesDb, model.toMap());
  }

  Future<void> editPackageItem(CorporationPackageServicesModel model,
      String title, String body,  int price) {
    model.title = title;
    model.body = body;
    model.price = price;
    db.editCollectionRef(DBConstants.corporationServicesDb, model.toMap());
  }

  Future<void> deactivatePackageItem(CorporationPackageServicesModel model) {
    model.isActive = false;
    db.editCollectionRef(DBConstants.corporationServicesDb, model.toMap());
  }
}