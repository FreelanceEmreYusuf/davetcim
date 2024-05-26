import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/helpers/parameters_helper.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/environments/const.dart';
import '../../../shared/models/corporation_model.dart';
import '../../../shared/models/paramters_model.dart';

class CorporationActivePassiveViewModel extends ChangeNotifier {
  Database db = Database();

  Future<void> editCorporationActivePassive(CorporationModel corporationModel) async {
    if (corporationModel.isActive) {
      corporationModel.isActive = false;
    } else {
      corporationModel.isActive = true;
    }

    db.editCollectionRef(DBConstants.corporationDb, corporationModel.toMap());
  }

  Future<void> editCorporationPopularity(CorporationModel corporationModel) async {
    if (corporationModel.isPopularCorporation) {
      corporationModel.isPopularCorporation = false;
      corporationModel.point = corporationModel.point -
          Constants.vipCorporationAdditionPoint;
    } else {
      corporationModel.isPopularCorporation = true;
      corporationModel.point = corporationModel.point +
          Constants.vipCorporationAdditionPoint;
    }

    db.editCollectionRef(DBConstants.corporationDb, corporationModel.toMap());
  }
}
