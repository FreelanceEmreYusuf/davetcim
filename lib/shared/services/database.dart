import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../environments/const.dart';

class Database {
  CollectionReference getCollectionRef(String collectionName) {
    // Constants.fireStore.clearPersistence();
    return Constants.fireStore.collection(collectionName);
  }

  Future<void> deleteDocument({String collectionName, String id}) async {
    await Constants.fireStore.collection(collectionName).doc(id).delete();
  }

  Future<void> addCollectionRef(
      String collectionName, Map<String, dynamic> dataAsMap) async {
    await Constants.fireStore
        .collection(collectionName)
        .add(dataAsMap)
        .then((value) => print("Veri " + collectionName + " tablosuna eklendi"))
        .catchError((error) => print("Veri " +
            collectionName +
            " tablosuna eklenirken hata oluştu: $error"));
    ;
  }
}
