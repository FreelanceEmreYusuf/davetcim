import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/language.dart';

import '../environments/db_constants.dart';
import '../models/corporation_model.dart';
import '../models/customer_model.dart';

class CorporateHelper {

  Future<CorporationModel> getCorporate(int corporateId) async {
    Database db = Database();
    var response = await db
        .getCollectionRef(DBConstants.corporationDb)
        .where('id', isEqualTo: corporateId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      CorporationModel corporate = CorporationModel.fromMap(list[0].data());
      return corporate;
    }

    return null;
  }
}
