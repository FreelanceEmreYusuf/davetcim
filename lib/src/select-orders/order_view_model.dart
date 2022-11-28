import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/combo_generic_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/models/corporation_model.dart';

class OrderViewModel extends ChangeNotifier {
  Database db = Database();


  Future<List<ComboGenericModel>> getOrganizationUniqueIdentifiers(int corporationId) async {
    List<ComboGenericModel> organizationList = [];

    CollectionReference docsRef = db.getCollectionRef(DBConstants.corporationDb);
    var response = await docsRef.where('id', isEqualTo: corporationId).get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      CorporationModel corporationModel = CorporationModel.fromMap(item);

      for(int i = 0; i < corporationModel.organizationUniqueIdentifier.length; i++) {
        int organizationId = int.parse(corporationModel.organizationUniqueIdentifier[i].toString());

        CollectionReference docsRef = db.getCollectionRef(DBConstants.organizationTypeDb);
        var response = await docsRef.where('id', isEqualTo: organizationId).get();

        if (response.docs != null && response.docs.length > 0) {
          var list = response.docs;
          Map item = list[0].data();

          var combo = ComboGenericModel();
          combo.id = int.parse(item['id'].toString());
          combo.text = item['name'].toString();
          organizationList.add(combo);
        }
      }
    }

    return organizationList;
  }

  Future<List<ComboGenericModel>> getInvitationIdentifiers(int corporationId) async {
    List<ComboGenericModel> invitationList = [];

    CollectionReference docsRef = db.getCollectionRef(DBConstants.corporationDb);
    var response = await docsRef.where('id', isEqualTo: corporationId).get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      CorporationModel corporationModel = CorporationModel.fromMap(item);

      for(int i = 0; i < corporationModel.invitationUniqueIdentifier.length; i++) {
        int organizationId = int.parse(corporationModel.invitationUniqueIdentifier[i].toString());

        CollectionReference docsRef = db.getCollectionRef(DBConstants.invitationTypeDb);
        var response = await docsRef.where('id', isEqualTo: organizationId).get();

        if (response.docs != null && response.docs.length > 0) {
          var list = response.docs;
          Map item = list[0].data();

          var combo = ComboGenericModel();
          combo.id = int.parse(item['id'].toString());
          combo.text = item['name'].toString();
          invitationList.add(combo);
        }
      }
    }

    return invitationList;
  }

  Future<List<ComboGenericModel>> getSequenceOrderIdentifiers(int corporationId) async {
    List<ComboGenericModel> sequenceOrderList = [];

    CollectionReference docsRef = db.getCollectionRef(DBConstants.corporationDb);
    var response = await docsRef.where('id', isEqualTo: corporationId).get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      CorporationModel corporationModel = CorporationModel.fromMap(item);

      for(int i = 0; i < corporationModel.sequenceOrderUniqueIdentifier.length; i++) {
        int organizationId = int.parse(corporationModel.sequenceOrderUniqueIdentifier[i].toString());

        CollectionReference docsRef = db.getCollectionRef(DBConstants.sequenceOrderDb);
        var response = await docsRef.where('id', isEqualTo: organizationId).get();

        if (response.docs != null && response.docs.length > 0) {
          var list = response.docs;
          Map item = list[0].data();

          var combo = ComboGenericModel();
          combo.id = int.parse(item['id'].toString());
          combo.text = item['name'].toString();
          sequenceOrderList.add(combo);
        }
      }
    }

    return sequenceOrderList;
  }




}
