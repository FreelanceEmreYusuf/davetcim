import 'package:cloud_firestore/cloud_firestore.dart';

import 'const.dart';

class Utils {
  static CollectionReference getCollectionRef(String collectionName) {
    // Constants.fireStore.clearPersistence();
    return Constants.fireStore.collection(collectionName);
  }
}
