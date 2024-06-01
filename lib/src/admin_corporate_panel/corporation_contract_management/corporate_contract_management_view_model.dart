import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../../../shared/environments/db_constants.dart';
import '../../../shared/models/corporation_extra_contract_model.dart';
import '../../../shared/models/corporation_main_contract_model.dart';
import '../../../shared/services/database.dart';
import '../../../shared/utils/dialogs.dart';

class CorporateContractManagementViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<CorporationMainContractModel>> getMainContractList(bool isSell) async {
    List<CorporationMainContractModel> contractList = [];
    var response = await db
        .getCollectionRef(DBConstants.corporationMainContractDb)
        .where('isSell', isEqualTo: isSell)
        .orderBy('id', descending: false)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        contractList.add(CorporationMainContractModel.fromMap(item));
      }
    }

    return contractList;
  }

  Future<String> getContract(int corporationId) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationExtraContractDb)
        .where('corporationId', isEqualTo: corporationId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      CorporationExtraContractModel corporationExtraContractModel =
          CorporationExtraContractModel.fromMap(item);
      return corporationExtraContractModel.contractBody;
    }

    return "";
  }

  Future<void> editContract(BuildContext context, int corporationId, String contractBody) async {
    CorporationExtraContractModel corporationExtraContractModel =
      new CorporationExtraContractModel(
          id : new DateTime.now().millisecondsSinceEpoch,
          corporationId: corporationId,
          contractBody: contractBody,
          recordDate : Timestamp.now()
      );

    var response = await db
        .getCollectionRef(DBConstants.corporationExtraContractDb)
        .where('corporationId', isEqualTo: corporationId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      corporationExtraContractModel =
        CorporationExtraContractModel.fromMap(item);
      corporationExtraContractModel.contractBody = contractBody;
      corporationExtraContractModel.recordDate = Timestamp.now();
    }

    db.editCollectionRef(DBConstants.corporationExtraContractDb,
        corporationExtraContractModel.toMap());

    Dialogs.showInfoModalContent(
        context,
        "Bilgi",
        "Sözleşme Maddeleriniz Sisteme Kaydedildi",
        null);
  }


}