import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/enums/corporation_event_log_enum.dart';
import '../../../shared/models/corporation_event_log_model.dart';
import '../../../shared/utils/date_utils.dart';


class CorporationAnalysisViewModel extends ChangeNotifier {
  Database db = Database();

  Future<CorporationEventLogModel> getDailyLog(int corporationId) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationEventLogDb)
        .where('corporationId', isEqualTo: corporationId)
        .where('date', isEqualTo: DateConversionUtils.getTodayAsInt())
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      return CorporationEventLogModel.fromMap(item);
    }

    return null;
  }

  Future<CorporationEventLogModel> getLogForScreen(int corporationId) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationEventLogDb)
        .where('corporationId', isEqualTo: corporationId)
        .where('date', isGreaterThanOrEqualTo: DateConversionUtils.getCurrentDateAsInt(
          DateTime(DateTime.now().year - 1, DateTime.now().month, DateTime.now().day)))
        .get();

    int dateMonthController = DateConversionUtils.getCurrentDateAsInt(
        DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day));

    CorporationEventLogModel corporationEventLogModel = new CorporationEventLogModel(
        id: new DateTime.now().millisecondsSinceEpoch,
        corporationId: corporationId,
        averageStarPoint: 0.0,
        commentCount: 0,
        commentCountMonth: 0,
        commentCountYear: 0,
        date: DateConversionUtils.getTodayAsInt(),
        recordDate: Timestamp.now(),
        favoriteCount: 0,
        favoriteCountMonth: 0,
        favoriteCountYear: 0,
        reservationCount: 0,
        reservationCountMonth: 0,
        reservationCountYear: 0,
        reservationTotalAmount: 0,
        reservationTotalAmountMonth: 0,
        reservationTotalAmountYear: 0,
        visitCount: 0,
        visitCountMonth: 0,
        visitCountYear: 0);

    if (response.docs != null && response.docs.length > 0) {
      int visitCount = 0, favoriteCount = 0, commentCount = 0, reservationCount = 0, reservationTotalAmount = 0;
      int visitCountMonth = 0, favoriteCountMonth = 0, commentCountMonth = 0, reservationCountMonth = 0, reservationTotalAmountMonth = 0;
      int visitCountYear = 0, favoriteCountYear = 0, commentCountYear = 0, reservationCountYear = 0, reservationTotalAmountYear = 0;
      double averageStar = 0.0;

      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        CorporationEventLogModel corporationEventRowLogModel = CorporationEventLogModel.fromMap(item);
        visitCountYear += corporationEventRowLogModel.visitCount;
        favoriteCountYear += corporationEventRowLogModel.favoriteCount;
        commentCountYear += corporationEventRowLogModel.commentCount;
        reservationCountYear += corporationEventRowLogModel.reservationCount;
        reservationTotalAmountYear = corporationEventRowLogModel.reservationTotalAmount;

        if (corporationEventRowLogModel.date >= dateMonthController) {
          visitCountMonth += corporationEventRowLogModel.visitCount;
          favoriteCountMonth += corporationEventRowLogModel.favoriteCount;
          commentCountMonth += corporationEventRowLogModel.commentCount;
          reservationCountMonth += corporationEventRowLogModel.reservationCount;
          reservationTotalAmountMonth = corporationEventRowLogModel.reservationTotalAmount;
        }

        if (corporationEventRowLogModel.date == DateConversionUtils.getTodayAsInt()) {
          visitCount += corporationEventRowLogModel.visitCount;
          favoriteCount += corporationEventRowLogModel.favoriteCount;
          commentCount += corporationEventRowLogModel.commentCount;
          reservationCount += corporationEventRowLogModel.reservationCount;
          reservationTotalAmount = corporationEventRowLogModel.reservationTotalAmount;
          averageStar = corporationEventRowLogModel.averageStarPoint;
        }
      }

      corporationEventLogModel.visitCount = visitCount;
      corporationEventLogModel.visitCountMonth = visitCountMonth;
      corporationEventLogModel.visitCountYear = visitCountYear;
      corporationEventLogModel.favoriteCount = favoriteCount;
      corporationEventLogModel.favoriteCountMonth = favoriteCountMonth;
      corporationEventLogModel.favoriteCountYear = favoriteCountYear;
      corporationEventLogModel.reservationCount = reservationCount;
      corporationEventLogModel.reservationCountMonth = reservationCountMonth;
      corporationEventLogModel.reservationCountYear = reservationCountYear;
      corporationEventLogModel.reservationTotalAmount = reservationTotalAmount;
      corporationEventLogModel.reservationTotalAmountMonth = reservationTotalAmountMonth;
      corporationEventLogModel.reservationTotalAmountYear = reservationTotalAmountYear;
      corporationEventLogModel.commentCount = commentCount;
      corporationEventLogModel.commentCountMonth = commentCountMonth;
      corporationEventLogModel.commentCountYear = commentCountYear;
      corporationEventLogModel.averageStarPoint = averageStar;
      return corporationEventLogModel;
    }

    return new CorporationEventLogModel(
        id: new DateTime.now().millisecondsSinceEpoch,
        corporationId: corporationId,
        averageStarPoint: 0.0,
        commentCount: 0,
        date: DateConversionUtils.getTodayAsInt(),
        recordDate: Timestamp.now(),
        favoriteCount: 0,
        reservationCount: 0,
        reservationTotalAmount: 0,
        visitCount: 0);
  }

  Future<CorporationEventLogModel> getDailyLogBetweenDates(int corporationId, DateTime beginDate, DateTime endDate) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationEventLogDb)
        .where('corporationId', isEqualTo: corporationId)
        .where('date', isGreaterThanOrEqualTo: DateConversionUtils.getCurrentDateAsInt(beginDate))
        .where('date', isLessThanOrEqualTo : DateConversionUtils.getCurrentDateAsInt(endDate))
        .get();

    CorporationEventLogModel corporationEventLogModel = new CorporationEventLogModel(
        id: new DateTime.now().millisecondsSinceEpoch,
        corporationId: corporationId,
        averageStarPoint: 0.0,
        commentCount: 0,
        date: DateConversionUtils.getTodayAsInt(),
        recordDate: Timestamp.now(),
        favoriteCount: 0,
        reservationCount: 0,
        reservationTotalAmount: 0,
        visitCount: 0);

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      int visitCount = 0, favoriteCount = 0, commentCount = 0, reservationCount = 0, reservationTotalAmount = 0;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        CorporationEventLogModel corporationEventRowLogModel = CorporationEventLogModel.fromMap(item);
        visitCount += corporationEventRowLogModel.visitCount;
        favoriteCount += corporationEventRowLogModel.favoriteCount;
        commentCount += corporationEventRowLogModel.commentCount;
        reservationCount += corporationEventRowLogModel.reservationCount;
        reservationTotalAmount = corporationEventRowLogModel.reservationTotalAmount;
      }

      corporationEventLogModel.reservationTotalAmount = reservationTotalAmount;
      corporationEventLogModel.visitCount = visitCount;
      corporationEventLogModel.favoriteCount = favoriteCount;
      corporationEventLogModel.commentCount = commentCount;
      corporationEventLogModel.reservationCount = reservationCount;
    }

    return corporationEventLogModel;
  }

  Future<void> editDailyLog(int corporationId, String logType, int value) async {
    CorporationEventLogModel corporationEventLogModel = await getDailyLog(corporationId);
    if (corporationEventLogModel == null) {
          corporationEventLogModel = new CorporationEventLogModel(
          id: new DateTime.now().millisecondsSinceEpoch,
          corporationId: corporationId,
          averageStarPoint: 0.0,
          commentCount: 0,
          date: DateConversionUtils.getTodayAsInt(),
          recordDate: Timestamp.now(),
          favoriteCount: 0,
          reservationCount: 0,
          reservationTotalAmount: 0,
          visitCount: 0);
    }

    if (logType == CorporationEventLogEnum.newVisit.name) {
      corporationEventLogModel.visitCount += 1;
    } else if (logType == CorporationEventLogEnum.newComment.name) {
      int totalCommentCount = corporationEventLogModel.commentCount;
      double totalStarPoint = (corporationEventLogModel.averageStarPoint * totalCommentCount) + value;
      corporationEventLogModel.commentCount += 1;
      corporationEventLogModel.averageStarPoint = totalStarPoint / corporationEventLogModel.commentCount;
    } else if (logType == CorporationEventLogEnum.newFavorite.name) {
      corporationEventLogModel.favoriteCount += 1;
    } else if (logType == CorporationEventLogEnum.newReservation.name) {
      corporationEventLogModel.reservationCount += 1;
      corporationEventLogModel.reservationTotalAmount += value;
    }

    corporationEventLogModel.recordDate = Timestamp.now();
    Map<String, dynamic> corporationEventLogMap = corporationEventLogModel.toMap();
    db.editCollectionRef(DBConstants.corporationEventLogDb, corporationEventLogMap);
  }

}
