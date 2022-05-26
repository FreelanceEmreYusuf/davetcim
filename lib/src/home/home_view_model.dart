import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeViewModel extends ChangeNotifier {

  Database db = Database();

  String getUserName() {
    if (ApplicationSession.userSession != null) {
      return ApplicationSession.userSession.username;
    }
    return "";
  }

  Stream<List<CorporationModel>> getHomeCorporationList()  {
      Stream<List<DocumentSnapshot>> corporationDocList = db.getCollectionRef("Corporation")
          .where('isPopularCorporation', isEqualTo: true)
          .snapshots()
          .map((event) => event.docs);

      Stream<List<CorporationModel>> corporationList = corporationDocList
          .map((event) => event.map((e) => CorporationModel.fromMap(e.data())).toList());

      return corporationList;

    }
/*
  Stream<List<CorporationModel>> streamProducts() {
    var ref = db.getCollectionRef("Corporation")
        .where('isPopularCorporation', isEqualTo: true).snapshots();

    return ref
        .map((list) => list.documents.map((doc) => CorporationModel.fromMap(doc))).toList(); // <= here
  }*/
}

