import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/environments/db_constants.dart';
import '../../../shared/models/corporate_sessions_model.dart';
import '../../../shared/services/database.dart';
import '../../reservation/reservation_view_model.dart';


class CorporateSessionsViewModel extends ChangeNotifier {
  Database db = Database();

  Future<CorporateSessionsModel> getSession(int sessionId) async {
    CollectionReference servicesListRef =
    db.getCollectionRef(DBConstants.corporationSessionsDb);
    var response = await servicesListRef
        .where('id', isEqualTo: sessionId).get();

    List<CorporateSessionsModel> sessionsList = [];
    var list = response.docs;
    CorporateSessionsModel sessionModel = CorporateSessionsModel.fromMap(list[0].data());
    return sessionModel;
  }

  Future<List<CorporateSessionsModel>> getSessions() async {
    CollectionReference servicesListRef =
    db.getCollectionRef(DBConstants.corporationSessionsDb);
    var response = await servicesListRef
        .where('corporationId', isEqualTo: ApplicationSession.userSession.corporationId).get();

    List<CorporateSessionsModel> sessionsList = [];
    var list = response.docs;
    for (int i = 0; i < list.length; i++) {
      CorporateSessionsModel sessionsModel = CorporateSessionsModel.fromMap(list[i].data());
      sessionsList.add(sessionsModel);
    }

    return sessionsList;
  }

  Future<void> addNewSession(String name, int midweekPrice, int weekendPrice) async {
    CorporateSessionsModel sessionModel = new CorporateSessionsModel(
        id: new DateTime.now().millisecondsSinceEpoch,
        corporationId: ApplicationSession.userSession.corporationId,
        name: name,
        midweekPrice: midweekPrice,
        weekendPrice: weekendPrice,
    );
    db.editCollectionRef(DBConstants.corporationSessionsDb, sessionModel.toMap());
  }

  Future<void> updateSession(int id, String name, int midweekPrice, int weekendPrice) async {
    CorporateSessionsModel servicePool = new CorporateSessionsModel(
      id: id,
      corporationId: ApplicationSession.userSession.corporationId,
      name: name,
      midweekPrice: midweekPrice,
      weekendPrice: weekendPrice,
    );
    db.editCollectionRef(DBConstants.corporationSessionsDb, servicePool.toMap());
  }

  Future<void> deleteSession(int id) async {
    db.deleteDocument(DBConstants.corporationSessionsDb, id.toString());
    ReservationViewModel rvm = ReservationViewModel();
    rvm.makeReservationPassive(id);
  }

}