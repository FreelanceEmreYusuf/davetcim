import 'package:davetcim/shared/sessions/reservation_edit_state.dart';
import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';

import '../shared/enums/reservation_status_enum.dart';
import '../shared/models/corporate_sessions_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/user_reservations/update/user_reservation_update_order_view.dart';

class UserReservationUpdateCartReservationItem extends StatefulWidget {
  final List<CorporateSessionsModel> sessionList;
  final int index;

  UserReservationUpdateCartReservationItem(
      {Key key,
      @required this.sessionList,
      @required this.index
      })
      : super(key: key);

  @override
  State<UserReservationUpdateCartReservationItem> createState() => _UserReservationUpdateCartReservationItemState();
}

class _UserReservationUpdateCartReservationItemState extends State<UserReservationUpdateCartReservationItem> {
  void navigateToBasket()  {
    ReservationEditState.reservationDetail.selectedSessionModel = widget.sessionList[widget.index];
    ReservationEditState.reservationDetail.reservationModel.date =
        ReservationEditState.reservationDetail.reservationModel.tempDate;
    Utils.navigateToPage(context, UserReservationUpdateOrderScreen());
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String reserveInfo = "Bu Seans Müsait";
    int reservationStatusFlag = 0;
    if (widget.sessionList[widget.index].hasReservation) {
      reservationStatusFlag = 1;
      if (widget.sessionList[widget.index].reservationStatus == ReservationStatusEnum.userOffer) {
        reserveInfo = "Teklif Oluşturuldu";
        color = Colors.yellowAccent;
      } else if (widget.sessionList[widget.index].reservationStatus == ReservationStatusEnum.preReservation) {
        reserveInfo = "Opsiyonlandı";
        color = Colors.blueAccent;
      } else if (widget.sessionList[widget.index].reservationStatus == ReservationStatusEnum.reservation) {
        reserveInfo = "Satış Oluşturuldu";
        color = Colors.redAccent;
      }
    } else if (DateConversionUtils.isOldDate(DateConversionUtils.getDateTimeFromIntDate(
        ReservationEditState.reservationDetail.reservationModel.date))) {
      color = Colors.grey;
      reserveInfo = "Bu seansın süresi doldu";
      reservationStatusFlag = 2;
    }

      return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: InkWell(
        onTap: ()  {
          if (reservationStatusFlag == 1) {
            Dialogs.showInfoModalContent(
                context,
                "Tarih Seçim Uyarısı",
                "Bu seans rezerve edilmiştir", null);
          } else if (reservationStatusFlag == 2) {
            Dialogs.showInfoModalContent(
                context,
                "Tarih Seçim Uyarısı",
                "Geçmiş tarihli rezervasyon yapılamaz", null);
          } else {
            navigateToBasket();
          }
        },
        child: Card(
          elevation: 8.0,
          child: ListView(
            children: <Widget>[
              ListTile(
                subtitle: Text(reserveInfo),
                title: Text(
                  widget.sessionList[widget.index].name,
                  style: TextStyle(
                    fontSize: 15,
                    color: color,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
