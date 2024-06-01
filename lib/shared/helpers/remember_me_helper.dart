import 'package:davetcim/shared/services/database.dart';

import '../environments/db_constants.dart';
import '../models/remember_me_model.dart';

class RememberMeHelper {

  Future<RememberMeModel> getByUserImeiCode(String imeiCode) async {
    Database db = Database();
    var response = await db
        .getCollectionRef(DBConstants.rememberMeDb)
        .where('imeiCode', isEqualTo: imeiCode)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      RememberMeModel rememberMeModel = RememberMeModel.fromMap(list[0].data());
      return rememberMeModel;
    }

    return null;
  }

  Future<RememberMeModel> getByUserName(String userName) async {
    Database db = Database();
    var response = await db
        .getCollectionRef(DBConstants.rememberMeDb)
        .where('userName', isEqualTo: userName)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      RememberMeModel rememberMeModel = RememberMeModel.fromMap(list[0].data());
      return rememberMeModel;
    }

    return null;
  }
}


