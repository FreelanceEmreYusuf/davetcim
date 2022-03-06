import 'package:cloud_firestore/cloud_firestore.dart';

import '../../environments/const.dart';

class Database {

  CollectionReference getCollectionRef(String collectionName) {
    // Constants.fireStore.clearPersistence();
    return Constants.fireStore.collection(collectionName);
  }
}