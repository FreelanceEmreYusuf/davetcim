import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared/models/generic_lookup_item_model.dart';
import '../../../shared/models/combo_generic_identifier_model.dart';


class ManageLookupsViewModel extends ChangeNotifier {
  Database db = Database();

  List<ComboGenericIdentifierModel> getLookupList() {
    List<ComboGenericIdentifierModel> responseList = [];
    ComboGenericIdentifierModel model = ComboGenericIdentifierModel();
    model.id = DBConstants.invitationTypeDb;
    model.text = "Davet Türü";
    responseList.add(model);

    model = ComboGenericIdentifierModel();
    model.id = DBConstants.organizationTypeDb;
    model.text = "Mekan Türü";
    responseList.add(model);

    model = ComboGenericIdentifierModel();
    model.id = DBConstants.sequenceOrderDb;
    model.text = "Oturma Düzeni";
    responseList.add(model);

    return responseList;
  }

  Future<List<GenericLookupItemModel>> getLookupTableList(String dbTable) async {
    var response = await db
        .getCollectionRef(dbTable)
        .where('id', isGreaterThan: 0)
     //   .orderBy('sortingIndex', descending: false)
        .get();

    List<GenericLookupItemModel> typesList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < response.docs.length; i++) {
        GenericLookupItemModel model = GenericLookupItemModel
            .fromMap(list[i].data());
        typesList.add(model);
      }
    }

    return typesList;
  }

  Future<void> addLookupItem(String dbTable, String name, int sortingIndex) {
    GenericLookupItemModel model = new GenericLookupItemModel(
        id: new DateTime.now().millisecondsSinceEpoch,
        filteringStatus: 1,
        name : name,
        sortingIndex: sortingIndex);

    db.editCollectionRef(dbTable, model.toMap());
  }

  Future<void> editLookupItem(GenericLookupItemModel model, String dbTable, String name, int sortingIndex) {
    model.name = name;
    model.sortingIndex = sortingIndex;
    db.editCollectionRef(dbTable, model.toMap());
  }
}