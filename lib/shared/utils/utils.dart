import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../shared/environments/const.dart';

class Utils {
  static CollectionReference getCollectionRef(String collectionName) {
    // Constants.fireStore.clearPersistence();
    return Constants.fireStore.collection(collectionName);
  }

  static void navigateToPage(BuildContext context, Widget childPage) {
    Navigator.push(context, PageTransition(type: PageTransitionType.fade,  child: childPage));
  }

  static void navigateToCallerPage(BuildContext context) {
    Navigator.pop(context);
  }
}
