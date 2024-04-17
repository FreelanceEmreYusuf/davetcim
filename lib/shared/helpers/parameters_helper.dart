import 'package:davetcim/shared/services/database.dart';

import '../environments/db_constants.dart';
import '../models/paramters_model.dart';

class ParametersHelper {
  Database db = Database();

  Future <ParametersModel> getParametersData() async {
    var response = await db
        .getCollectionRef(DBConstants.parametersDataDb)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      if (list.length > 0) {
        Map item = list[0].data();
        return ParametersModel.fromMap(item);
      }
    }

    return null;
  }
}