import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/environments/db_constants.dart';
import '../../shared/models/corporation_model.dart';
import '../../shared/services/database.dart';

class ProductsViewDetailModel extends ChangeNotifier {
  Database db = Database();

  Future<List<String>> getImagesList(int corporationId) async {
    var response = await db
        .getCollectionRef(DBConstants.imagesDb)
        .where('corporationId', isEqualTo: corporationId)
        .get();


    var response2 = await db
        .getCollectionRef(DBConstants.corporationDb)
        .where('id', isEqualTo: corporationId)
        .get();

    List<String> imageList = [];
    List<int> idList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        imageList.add(item["imageUrl"]);
        idList.add(item["id"]);
      }
    }

    List<String> sortedImageList = [];
    List<int> reversedIdList = List.from(idList.reversed); // idList'i tersine çevirerek bir kopyasını oluşturuyoruz
    for (int id in reversedIdList) {
      int index = idList.indexOf(id);
      sortedImageList.add(imageList[index]);
    }

    String imgUrl = "";
    if (response2.docs != null && response2.docs.length > 0) {
      var list2 = response2.docs;
      for (int i = 0; i < list2.length; i++) {
        Map item = list2[i].data();
        imgUrl = item["imageUrl"];

        // imgUrl değeri sortedImageList'in ilk elemanı ise, listeden çıkar
        if (sortedImageList.contains(imgUrl)) {
          sortedImageList.remove(imgUrl);
        }

        // imgUrl değerini listede ilk eleman yap
        sortedImageList.insert(0, imgUrl);
      }
    }

    return sortedImageList;

  }

  Future<List<String>> getHashtagList(int corporationId) async {
    List<String> hashtagList = [];
    CollectionReference docsRef = db.getCollectionRef(DBConstants.corporationDb);
    var response = await docsRef.where('id', isEqualTo: corporationId).get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      CorporationModel corporationModel = CorporationModel.fromMap(item);
      String regionName = await getRegion(int.parse(corporationModel.region));
      String districtName = await getDistrict(int.parse(corporationModel.district));
      List<String> organizationUniqueIdentifiers =
        await getOrganizationUniqueIdentifiers(corporationModel.organizationUniqueIdentifier);
      List<String> invitationUniqueIdentifiers =
        await getInvitationIdentifiers(corporationModel.invitationUniqueIdentifier);
      List<String> sequenceOrderUniqueIdentifiers =
        await getSequenceOrderIdentifiers(corporationModel.sequenceOrderUniqueIdentifier);
      hashtagList.add(regionName);
      hashtagList.add(districtName);
      hashtagList.addAll(organizationUniqueIdentifiers);
      hashtagList.addAll(invitationUniqueIdentifiers);
      hashtagList.addAll(sequenceOrderUniqueIdentifiers);
      hashtagList.add("Max Kapasite "+item["maxPopulation"].toString());
    }

    return hashtagList;

  }

  Future<String> getRegion(int regionId) async {
    CollectionReference docsRef = db.getCollectionRef(DBConstants.regionDb);
    var response = await docsRef.where('id', isEqualTo: regionId).get();
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      return '#' + item['name'].toString();
    }
    return '';
  }

  Future<String> getDistrict(int districtId) async {
    CollectionReference docsRef = db.getCollectionRef(DBConstants.districtDb);
    var response = await docsRef.where('id', isEqualTo: districtId).get();
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      return '#' + item['name'].toString();
    }
    return '';
  }

  Future<List<String>> getOrganizationUniqueIdentifiers(List<String> organizationArray) async {
    List<String> organizationList = [];
    for(int i = 0; i < organizationArray.length; i++) {
      int organizationId = int.parse(organizationArray[i].toString());

      CollectionReference docsRef = db.getCollectionRef(DBConstants.organizationTypeDb);
      var response = await docsRef.where('id', isEqualTo: organizationId).get();

      if (response.docs != null && response.docs.length > 0) {
        var list = response.docs;
        Map item = list[0].data();
        organizationList.add('#' + item['name'].toString());
      }
    }

    return organizationList;
  }

  Future<List<String>> getInvitationIdentifiers(List<String> organizationArray) async {
    List<String> invitationList = [];
    for(int i = 0; i < organizationArray.length; i++) {
      int organizationId = int.parse(organizationArray[i].toString());

      CollectionReference docsRef = db.getCollectionRef(DBConstants.invitationTypeDb);
      var response = await docsRef.where('id', isEqualTo: organizationId).get();

      if (response.docs != null && response.docs.length > 0) {
        var list = response.docs;
        Map item = list[0].data();
        invitationList.add('#' + item['name'].toString());
      }
    }

    return invitationList;
  }

  Future<List<String>> getSequenceOrderIdentifiers(List<String> organizationArray) async {
    List<String> sequenceOrderList = [];
    for(int i = 0; i < organizationArray.length; i++) {
      int organizationId = int.parse(organizationArray[i].toString());

      CollectionReference docsRef = db.getCollectionRef(DBConstants.sequenceOrderDb);
      var response = await docsRef.where('id', isEqualTo: organizationId).get();

      if (response.docs != null && response.docs.length > 0) {
        var list = response.docs;
        Map item = list[0].data();
        sequenceOrderList.add('#' + item['name'].toString());
      }
    }

    return sequenceOrderList;
  }
  
  
  
  
}