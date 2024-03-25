import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';

import '../shared/dto/reservation_detail_view_dto.dart';
import '../shared/models/corporate_sessions_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/user_reservations/update/user_reservation_update_order_view.dart';

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
    int reservationStatusFlag = 0;
    if (widget.sessionList[widget.index].hasReservation) {
      color = Colors.red;
      reserveInfo = "Rezerve Edilmiştir";
      reservationStatusFlag = 1;
    } else if (DateConversionUtils.isOldDate(widget.date)) {
      color = Colors.grey;
      reserveInfo = "Bu seansın süresi doldu";
      reservationStatusFlag = 2;
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
