import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_cache.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/dto/basket_user_dto.dart';
import '../../../shared/enums/reservation_status_enum.dart';
import '../../../shared/models/corporation_model.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/utils/date_utils.dart';

class SummaryBasketViewModel extends ChangeNotifier {
  Database db = Database();

  Future<bool> controReeservation(BasketUserDto basketModel) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('sessionId', isEqualTo: basketModel.selectedSessionModel.id)
        .where('isActive', isEqualTo: true)
        .where('date', isEqualTo: basketModel.date)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      return true;
    }

    return false;
  }

  Future<int> getMinReservationAmount(int corporateId) async {
    CorporateHelper corporateHelper = CorporateHelper();
    CorporationModel corporationModel = await corporateHelper.getCorporate(corporateId);
    return corporationModel.minReservationAmount;
  }

  Future<ReservationModel> createNewReservation(BasketUserDto basketModel, String description) async {
    bool hasReservation = await controReeservation(basketModel);
    if (hasReservation) {
      return null;
    }

    int reservationId = new DateTime.now().millisecondsSinceEpoch;

    int sessionCost = basketModel.selectedSessionModel.midweekPrice;
    if(DateConversionUtils.isWeekendFromIntDate(basketModel.date) ){
      sessionCost = basketModel.selectedSessionModel.weekendPrice;
    }

    ReservationModel reservationModel = new ReservationModel(
      id: reservationId,
      corporationId: basketModel.corporationModel.corporationId,
      customerId: ApplicationCache.userCache.id,
      cost: basketModel.totalPrice,
      date: basketModel.date,
      recordDate: Timestamp.now(),
      description: description,
      sessionId: basketModel.selectedSessionModel.id,
      sessionName: basketModel.selectedSessionModel.name,
      sessionCost: sessionCost,
      reservationStatus: ReservationStatusEnum.newRecord,
      isActive: true,
      invitationCount: basketModel.orderBasketModel.count,
      invitationType: basketModel.orderBasketModel.invitationType,
      seatingArrangement: basketModel.orderBasketModel.sequenceOrder
    );

    db.editCollectionRef(DBConstants.corporationReservationsDb, reservationModel.toMap());
    await createNewReservationDetail(basketModel, reservationId);
    return reservationModel;
  }

  Future<void> createNewReservationDetail(BasketUserDto basketModel, int reservationId) async {
    int id = new DateTime.now().millisecondsSinceEpoch;
    if (basketModel.servicePoolModel != null) {
      for (int i = 0; i < basketModel.servicePoolModel.length; i++) {
        ServicePoolModel model = basketModel.servicePoolModel[i];
        ReservationDetailModel reservationModel = new ReservationDetailModel(
          id: id,
          reservationId: reservationId,
          foreignId: model.id,
          foreignType: "service",
          serviceName: model.serviceName.replaceAll("-", ""),
          serviceBody: "",
          price: model.corporateDetail.price,
          priceChangedForCount: model.corporateDetail.priceChangedForCount,
          hasPrice: model.corporateDetail.hasPrice,
        );
        id += 1;

        await db.editCollectionRef(DBConstants.reservationDetailDb, reservationModel.toMap());
      }
    }

    if (basketModel.packageModel != null) {
      ReservationDetailModel reservationModel = new ReservationDetailModel(
        id: (id + 1),
        reservationId: reservationId,
        foreignId: basketModel.packageModel.id,
        foreignType: "package",
        serviceName: basketModel.packageModel.title,
        serviceBody: basketModel.packageModel.body,
        price: basketModel.packageModel.price,
        priceChangedForCount: true,
        hasPrice: true
      );

      db.editCollectionRef(DBConstants.reservationDetailDb, reservationModel.toMap());
    }
  }
}
