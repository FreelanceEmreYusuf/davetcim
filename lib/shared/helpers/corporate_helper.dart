import 'package:davetcim/shared/services/database.dart';

import '../environments/db_constants.dart';
import '../models/corporation_model.dart';

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

  Future<List<CorporationModel>> getCorporateByCompany(int companyId) async {
    Database db = Database();
    List<CorporationModel> corporationList = [];
    var response = await db
        .getCollectionRef(DBConstants.corporationDb)
        .where('companyId', isEqualTo: companyId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        corporationList.add(CorporationModel.fromMap(list[i].data()));
      }
    }

    return corporationList;
  }
}
