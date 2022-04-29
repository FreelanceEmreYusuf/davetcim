import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../shared/environments/const.dart';

class Utils {
  static CollectionReference getCollectionRef(String collectionName) {
    // Constants.fireStore.clearPersistence();
    return Constants.fireStore.collection(collectionName);
  }

  static void navigateToPage(BuildContext context, Widget childPage) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return childPage;
        },
      ),
    );
  }
}
