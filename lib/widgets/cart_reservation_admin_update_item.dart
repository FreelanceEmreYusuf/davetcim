import 'package:davetcim/shared/models/reservation_model.dart';
import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';

import '../shared/enums/reservation_status_enum.dart';
import '../shared/models/corporate_sessions_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/all_reservation/all_reservation_corporate_landing_view.dart';
import '../src/admin_corporate_panel/all_reservation/all_reservation_corporate_view_model.dart';

class CartReservationAdminUpdateItem extends StatefulWidget {
  final ReservationModel reservationModel;
  final List<CorporateSessionsModel> sessionList;
  final int index;
  final int date;

  CartReservationAdminUpdateItem(
      {Key key,
      @required this.reservationModel,
      @required this.sessionList,
      @required this.index,
      @required this.date
      })
      : super(key: key);

  @override
  State<CartReservationAdminUpdateItem> createState() => _CartReservationAdminUpdateItemState();
}

class _CartReservationAdminUpdateItemState extends State<CartReservationAdminUpdateItem> {

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String reserveInfo = "Bu Seans Müsait";
    String dialogInfo = "";
    int reservationStatusFlag = 0;
    if (widget.sessionList[widget.index].hasReservation) {
      reservationStatusFlag = 1;
      if (widget.reservationModel.reservationStatus == ReservationStatusEnum.userOffer) {
        reserveInfo = "Teklif Oluşturuldu";
        dialogInfo = "Bu seans için teklif oluşturuldu.";
        color = Colors.blueGrey;
      } else if (widget.reservationModel.reservationStatus == ReservationStatusEnum.preReservation) {
        reserveInfo = "Opsiyonlandı";
        dialogInfo = "Bu seans opsiyonlandı.";
        color = Colors.blueAccent;
      } else if (widget.reservationModel.reservationStatus == ReservationStatusEnum.reservation) {
        reserveInfo = "Satış Oluşturuldu";
        dialogInfo = "Bu seans için satış işlemi gerçekleşti.";
        color = Colors.redAccent;
      }
    } else if (DateConversionUtils.isOldDate(DateConversionUtils.getDateTimeFromIntDate(
        widget.reservationModel.date))) {
      color = Colors.grey;
      reserveInfo = "Süresi dolmuş seans";
      dialogInfo = "Geçmiş tarihli teklif oluşturulamaz.";
      reservationStatusFlag = 2;
    }

      return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: InkWell(
        onTap: ()  {
          if (reservationStatusFlag != 0) {
            Dialogs.showInfoModalContent(
                context,
                "Tarih Seçim Uyarısı",
                dialogInfo, null);
          } else {
            widget.reservationModel.sessionId = widget.sessionList[widget.index].id;
            widget.reservationModel.sessionName = widget.sessionList[widget.index].name;
            widget.reservationModel.sessionCost = widget.sessionList[widget.index].midweekPrice;
            widget.reservationModel.date = widget.date;
            if(DateConversionUtils.isWeekendFromIntDate(widget.reservationModel.date) ){
              widget.reservationModel.sessionCost = widget.sessionList[widget.index].weekendPrice;
            }

            AllReservationCorporateViewModel allReservationCorporateViewModel = AllReservationCorporateViewModel();
            allReservationCorporateViewModel.delayReservation(context, widget.reservationModel);
            Utils.navigateToPage(context, AllReservationLandingView(pageIndex: 1));
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
