import 'package:davetcim/shared/services/database.dart';

import '../environments/db_constants.dart';
import '../models/paramters_model.dart';
import '../sessions/parameters_state.dart';

class ParametersHelper {
  Database db = Database();

  Future <ParametersModel> getParametersData() async {
    if (ParametersState.isPresent()) {
      return ParametersState.parametersModel;
    }

    var response = await db
        .getCollectionRef(DBConstants.parametersDataDb)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      if (list.length > 0) {
        Map item = list[0].data();
        ParametersState.set(ParametersModel.fromMap(item));
        return ParametersModel.fromMap(item);
      }
    }

    return null;
  }
}