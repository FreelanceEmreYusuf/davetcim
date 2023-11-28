import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';

import '../shared/dto/reservation_detail_view_dto.dart';
import '../shared/models/corporate_sessions_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/user_reservations/update/user_reservation_update_order_view.dart';

class UserReservationUpdateCartReservationItem extends StatefulWidget {
  final ReservationDetailViewDto detailResponse;
  final List<CorporateSessionsModel> sessionList;
  final int index;

  UserReservationUpdateCartReservationItem(
      {Key key,
      @required this.detailResponse,
      @required this.sessionList,
      @required this.index
      })
      : super(key: key);

  @override
  State<UserReservationUpdateCartReservationItem> createState() => _UserReservationUpdateCartReservationItemState();
}

class _UserReservationUpdateCartReservationItemState extends State<UserReservationUpdateCartReservationItem> {
  void navigateToBasket()  {
    widget.detailResponse.selectedSessionModel = widget.sessionList[widget.index];
    Utils.navigateToPage(context, UserReservationUpdateOrderScreen(detailResponse: widget.detailResponse));
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String reserveInfo = "Bu Seans Müsait";
    int reservationStatusFlag = 0;
    if (widget.detailResponse.selectedSessionModel.hasReservation) {
      color = Colors.red;
      reserveInfo = "Rezerve Edilmiştir";
      reservationStatusFlag = 1;
    } else if (DateConversionUtils.isOldDate(DateConversionUtils.getDateTimeFromIntDate(
        widget.detailResponse.reservationModel.date))) {
      color = Colors.grey;
      reserveInfo = "Bu seansın süresi doldu";
      reservationStatusFlag = 2;
    }

      return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: InkWell(
        onTap: ()  {
          if (reservationStatusFlag == 1) {
            Dialogs.showAlertMessage(
                context,
                "Tarih Seçim Uyarısı",
                "Bu seans rezerve edilmiştir");
          } else if (reservationStatusFlag == 2) {
            Dialogs.showAlertMessage(
                context,
                "Tarih Seçim Uyarısı",
                "Geçmiş tarihli rezervasyon yapılamaz");
          } else {
            navigateToBasket();
           /* TODO : Dialogs.showDialogMessage(
                context,
                "Tarih Seçimi",
                DateConversionUtils.getDateTimeFromIntDate(widget.basketModel.date).toString().substring(0, 10) +
                    " Tarihi ve " + widget.basketModel.sessionModel.name + " Seansı için rezervasyon " +
                    "yapmak istediğinizden emin misiniz?",
                navigateToBasket, '');*/
          }
        },
        child: Card(
          elevation: 8.0,
          child: ListView(
            children: <Widget>[
              ListTile(
                subtitle: Text(reserveInfo),
                title: Text(
                  widget.detailResponse.selectedSessionModel.name,
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
