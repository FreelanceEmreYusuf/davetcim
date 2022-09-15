import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/environments/const.dart';

class Database {
  CollectionReference getCollectionRef(String collectionName) {
    return Constants.fireStore.collection(collectionName);
  }

  Stream<QuerySnapshot> getCollectionQuerySnapshots(String collectionName) {
    return Constants.fireStore.collection(collectionName).snapshots();
  }

  Future<void> deleteDocument({String collectionName, String id}) async {
    await Constants.fireStore.collection(collectionName).doc(id).delete();
  }

  Future<void> editCollectionRef(
      String collectionName, Map<String, dynamic> dataAsMap) async {
    await Constants.fireStore
        .collection(collectionName)
        .doc(dataAsMap["id"].toString())
        .set(dataAsMap)
        .then((value) =>
            print("Veri " + collectionName + " tablosuna eklendi/guncellendi"))
        .catchError((error) => print("Veri " +
            collectionName +
            " tablosuna eklenirken/guncellenirken hata oluştu: $error"));
  }
}
