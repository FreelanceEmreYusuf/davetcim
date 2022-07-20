import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/dto/product_filterer.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';

class ProductsViewModel extends ChangeNotifier {

  Database db = Database();

  Future<List<int>>  getInvitationUniqueIdentifierList(ProductFilterer filter) async {
    var response = await db
        .getCollectionRef("Corporation")
        .where('invitationUniqueIdentifier', arrayContains: filter.invitationUniqueIdentifier)
        .get();

    List<CorporationModel> corpModelList = [];
    List<int> corpModelListIDs = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        corpModelList.add(CorporationModel.fromMap(list[i].data()));
      }
    }

    for (int i = 0; i < corpModelList.length; i++) {
      corpModelListIDs.add(corpModelList[i].corporationId);
    }

    return corpModelListIDs;
  }

  Future<List<int>>  getOrganizationUniqueIdentifierList(ProductFilterer filter) async {
    var response = await db
        .getCollectionRef("Corporation")
        .where('organizationUniqueIdentifier', arrayContains: filter.organizationUniqueIdentifier)
        .get();

    List<CorporationModel> corpModelList = [];
    List<int> corpModelListIDs = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        corpModelList.add(CorporationModel.fromMap(list[i].data()));
      }
    }

    for (int i = 0; i < corpModelList.length; i++) {
      corpModelListIDs.add(corpModelList[i].corporationId);
    }

    return corpModelListIDs;
  }


  Future<List<int>>  getFilteredCompanyIds(ProductFilterer filter) async {
    List<int> unqInvitationList = [];
    List<int> unqOrganizationList = [];

    if (filter.invitationUniqueIdentifier != "0") {
      unqInvitationList = await getInvitationUniqueIdentifierList(filter);
      if (unqInvitationList == null) {
        unqInvitationList = [];
      }
    }
    if (filter.organizationUniqueIdentifier != "0") {
      unqOrganizationList = await getOrganizationUniqueIdentifierList(filter);
      if (unqOrganizationList == null) {
        unqOrganizationList = [];
      }
    }

    List<int> resultIdList = [];
    if (filter.invitationUniqueIdentifier != "0" && filter.organizationUniqueIdentifier != "0") {
      for (int i = 0; i < unqInvitationList.length; i++) {
        for (int j = 0; j < unqOrganizationList.length; j++) {
          if (unqInvitationList[i] == unqOrganizationList[j]) {
            resultIdList.add(unqInvitationList[i]);
            break;
          }
        }
      }
    } else if (filter.invitationUniqueIdentifier != "0") {
      return unqInvitationList;
    } else if (filter.organizationUniqueIdentifier != "0") {
      return unqOrganizationList;
    } else {
      return null;
    }

    return resultIdList;
  }

  Future<List<CorporationModel>> filterCorporationListForReservations(ProductFilterer filter) async {
    var response = await db
        .getCollectionRef("CorporationReservations")
        .where('date', isEqualTo: DateUtils.getCurrentDateAsInt())
       // .where('corporationId', whereNotIn: corporationIds)
        .get();
  }


  Future<List<CorporationModel>> getCorporationList(ProductFilterer filter) async {

    Query list = db.getCollectionRef("Corporation");
    if (int.parse(filter.region) > 0) {
      list = list.where('region', isEqualTo: filter.region);
    }
    if (!filter.district.contains('00')) {
      list = list.where('district', isEqualTo: filter.district);
    }
    if (filter.maxPopulation.isNotEmpty) {
      list = list.where('maxPopulation', isGreaterThanOrEqualTo:  int.parse(filter.maxPopulation));
    }

    List<int> unqList = await getFilteredCompanyIds(filter);
    if (unqList != null) {
      list = list.where('id', whereIn: unqList);
    }

    if (filter.sequenceOrderUniqueIdentifier != "0") {
      list = list.where('sequenceOrderUniqueIdentifier', arrayContains: filter.sequenceOrderUniqueIdentifier);
    }

    var response = await list.get();
    List<CorporationModel> corpModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        corpModelList.add(CorporationModel.fromMap(list[i].data()));
      }
    }

    return corpModelList;

  }
}