import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/enums/reservation_status_enum.dart';
import '../../shared/models/corporate_sessions_model.dart';
import '../../shared/models/reservation_model.dart';
import '../../shared/services/database.dart';
import '../../shared/utils/date_utils.dart';

class ReservationViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ReservationModel>> getReservationlist(int corporateId) async {
    var response = await db
        .getCollectionRef("CorporationReservations")
        .where('corporationId', isEqualTo: corporateId)
        .where('isActive', isEqualTo: true)
        .where('reservationStatus', isGreaterThan: ReservationStatusEnum.userOffer.index)
        .get();

    List<ReservationModel> corpModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        corpModelList.add(ReservationModel.fromMap(item));
      }
    }

    return corpModelList;
  }


  Stream<List<ReservationModel>> getReservationStreamlist(int corporateId, DateTime dateTime) {
    Stream<List<DocumentSnapshot>> reservationListInfo = db
        .getCollectionRef("CorporationReservations")
        .where('corporationId', isEqualTo: corporateId)
        .where('isActive', isEqualTo: true)
        .where('date', isEqualTo: DateConversionUtils.getCurrentDateAsInt(dateTime))
        .snapshots()
        .map((event) => event.docs);

    Stream<List<ReservationModel>> reservationModellist = reservationListInfo
        .map((event) => event.map((e) => ReservationModel.fromMap(e.data())).toList());

    return reservationModellist;
  }

  Future<CorporateSessionsModel> getSessionDetail(int sessionId) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationSessionsDb)
        .where('id', isEqualTo: sessionId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      CorporateSessionsModel model = CorporateSessionsModel.fromMap(item);
      return model;
    }

    return null;
  }


  Future<List<CorporateSessionsModel>> getSessionReservationExtraction(int corporateId, int date) async {
    List<CorporateSessionsModel> sessionList = await getSessionList(corporateId);
    List<ReservationModel> reservationList =  await getReservationWithDatelist(corporateId, date);

    for (int i = 0; i < sessionList.length; i++) {
      CorporateSessionsModel sessionModel = sessionList[i];
      sessionModel.hasReservation = false;

      for(int j = 0; j < reservationList.length; j++) {
        ReservationModel reservationModel = reservationList[j];

        if (sessionModel.id == reservationModel.sessionId) {
          sessionModel.hasReservation = true;
          sessionModel.reservationStatus = reservationModel.reservationStatus;
        }
      }
    }

    return sessionList;
  }

  Future<List<CorporateSessionsModel>> getSessionReservationExtractionForUpdate
      (int corporateId, int date, int sessionId, int customerId) async {
    List<CorporateSessionsModel> sessionList = await getSessionList(corporateId);
    List<ReservationModel> reservationList =  await getReservationWithDatelist(corporateId, date);

    for (int i = 0; i < sessionList.length; i++) {
      CorporateSessionsModel sessionModel = sessionList[i];
      sessionModel.hasReservation = false;

      for(int j = 0; j < reservationList.length; j++) {
        ReservationModel reservationModel = reservationList[j];
        if (reservationModel.customerId == customerId && reservationModel.sessionId == sessionId) {
          continue;
        }
        if (sessionModel.id == reservationModel.sessionId) {
          sessionModel.hasReservation = true;
        }
      }
    }

    return sessionList;
  }

  Future<List<CorporateSessionsModel>> getSessionReservationForAllCorporatesExtraction(int date) async {
    List<CorporateSessionsModel> sessionList = await getAllSessionList();
    List<ReservationModel> reservationList =  await getReservationAllWithDatelist(date);

    for (int i = 0; i < sessionList.length; i++) {
      CorporateSessionsModel sessionModel = sessionList[i];
      sessionModel.hasReservation = false;

      for(int j = 0; j < reservationList.length; j++) {
        ReservationModel reservationModel = reservationList[j];

        if (sessionModel.id == reservationModel.sessionId
          && sessionModel.corporationId == reservationModel.corporationId) {
          sessionModel.hasReservation = true;
        }
      }
    }

    return sessionList;
  }

  Future<List<CorporateSessionsModel>> getSessionList(int corporateId) async {
    List<CorporateSessionsModel> sessionList = [];
    List<ReservationModel> reservationList = [];

    var response = await db
        .getCollectionRef(DBConstants.corporationSessionsDb)
        .where('corporationId', isEqualTo: corporateId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        sessionList.add(CorporateSessionsModel.fromMap(item));
      }
    }

    return sessionList;
  }

  Future<List<CorporateSessionsModel>> getAllSessionList() async {
    List<CorporateSessionsModel> sessionList = [];
    List<ReservationModel> reservationList = [];

    var response = await db
        .getCollectionRef(DBConstants.corporationSessionsDb)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        sessionList.add(CorporateSessionsModel.fromMap(item));
      }
    }

    return sessionList;
  }

  Future<List<ReservationModel>> getReservationWithDatelist(int corporateId, int date) async {
    var response = await db
        .getCollectionRef("CorporationReservations")
        .where('corporationId', isEqualTo: corporateId)
        .where('isActive', isEqualTo: true)
        .where('reservationStatus', isNotEqualTo: ReservationStatusEnum.userOffer.index)
        .where('date', isEqualTo: date)
        .get();

    List<ReservationModel> corpModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        corpModelList.add(ReservationModel.fromMap(item));
      }
    }

    return corpModelList;
  }

  Future<List<ReservationModel>> getReservationAllWithDatelist(int date) async {
    var response = await db
        .getCollectionRef("CorporationReservations")
        .where('isActive', isEqualTo: true)
        .where('date', isEqualTo: date)
        .get();

    List<ReservationModel> corpModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        corpModelList.add(ReservationModel.fromMap(item));
      }
    }

    return corpModelList;
  }

  Future<void> makeReservationPassive(int sessionId) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('sessionId', isEqualTo: sessionId)
        .where('isActive', isEqualTo: true)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        item['isActive'] = false;
        ReservationModel reservationModel = ReservationModel.fromMap(item);
        db.editCollectionRef(
            DBConstants.corporationReservationsDb, reservationModel.toMap());
      }
    }
  }
}