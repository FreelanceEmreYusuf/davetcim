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

  static String generateText(GeneralDataModel model){
    String text = "";
    if(model.title != null && model.title != "")
      text += model.title.toUpperCase()+"\n\n";
    if(model.subtitle != null && model.subtitle != "")
      text += model.subtitle+"\n\n\n";
    if(model.title2 != null && model.title2 != "")
      text += model.title2.toUpperCase()+"\n\n";
    if(model.subtitle2 != null && model.subtitle2 != "")
      text += model.subtitle2+"\n\n\n";
    if(model.title3 != null && model.title3 != "")
      text += model.title3.toUpperCase()+"\n\n";
    if(model.subtitle3 != null && model.subtitle3 != "")
      text += model.subtitle3+"\n\n\n";
    if(model.title4 != null && model.title4 != "")
      text += model.title4.toUpperCase()+"\n\n";
    if(model.subtitle4 != null && model.subtitle4 != "")
      text += model.subtitle4+"\n\n\n";
    if(model.title5 != null && model.title5 != "")
      text += model.title5.toUpperCase()+"\n\n";
    if(model.subtitle5 != null && model.subtitle5 != "")
      text += model.subtitle5+"\n\n\n";

    return text.replaceAll("\\n", "\n");
  }

  static String formatMoney(String amount) {
    String formattedAmount = '';

    int length = amount.length;
    int dotIndex = length % 3;

    if (dotIndex != 0) {
      formattedAmount += amount.substring(0, dotIndex) + '.';
    }

    for (int i = dotIndex; i < length; i += 3) {
      formattedAmount += amount.substring(i, i + 3) + '.';
    }

    formattedAmount = formattedAmount.substring(0, formattedAmount.length - 1);

    return formattedAmount;
  }

  static String removeLeadingHyphens(String text) {
    // Metnin sol başındaki boşlukları temizle
    String trimmedText = text.trimLeft();

    // Tire işaretlerini sil
    return trimmedText.replaceAll(RegExp('-'), '');
  }

}