import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/shared/models/comment_model.dart';
import 'package:davetcim/shared/models/reservation_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/language.dart';

import '../environments/db_constants.dart';
import '../models/corporation_model.dart';
import '../models/customer_model.dart';
import '../models/general_data_model.dart';
import '../models/insurance_model.dart';

class GeneralHelper {
  Database db = Database();

  Future<bool> checkInsurance() async {
    var response = await db
        .getCollectionRef(DBConstants.insuranceDB)
        .where('id', isEqualTo: 1)
        .get();

    List<InsuranceModel> insuranceModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        insuranceModelList.add(InsuranceModel.fromMap(item));
      }
    }
    return !insuranceModelList.first.insurance;
  }

  Future<List<GeneralDataModel>> getGeneralData() async {
    var response = await db
        .getCollectionRef(DBConstants.generalDataDb)
        .get();

    List<GeneralDataModel> generalDataModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        generalDataModelList.add(GeneralDataModel.fromMap(item));
      }
    }
    return generalDataModelList;
  }

}