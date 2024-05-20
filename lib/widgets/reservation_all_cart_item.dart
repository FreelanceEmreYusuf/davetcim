import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';

import '../shared/enums/reservation_status_enum.dart';
import '../shared/models/corporate_sessions_model.dart';

class ReservationSessionsAllCartItem extends StatefulWidget {
  final List<CorporateSessionsModel> sessionList;
  final DateTime date;
  final int index;

  ReservationSessionsAllCartItem(
      {Key key,
      @required this.sessionList,
      @required this.date,
      @required this.index
      })
      : super(key: key);

  @override
  State<ReservationSessionsAllCartItem> createState() => _ReservationSessionsAllCartItemState();
}

class _ReservationSessionsAllCartItemState extends State<ReservationSessionsAllCartItem> {

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String reserveInfo = "Bu Seans Müsait";

    if (widget.sessionList[widget.index].hasReservation) {
      color = Colors.red;
      reserveInfo = "Rezerve Edilmiştir";

      if (widget.sessionList[widget.index].reservationStatus ==
          ReservationStatusEnum.userOffer) {
        reserveInfo = "Teklif Oluşturuldu";
        color = Colors.lightBlueAccent;
      } else if (widget.sessionList[widget.index].reservationStatus ==
          ReservationStatusEnum.preReservation) {
        reserveInfo = "Opsiyonlandı";
        color = Colors.blueAccent;
      } else if (widget.sessionList[widget.index].reservationStatus ==
          ReservationStatusEnum.reservation) {
        reserveInfo = "Satış Oluşturuldu";
        color = Colors.redAccent;
      }
    } else if (DateConversionUtils.isOldDate(widget.date)) {
      color = Colors.grey;
      reserveInfo = "Bu seansın süresi doldu";
    }

      return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: InkWell(
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
