import 'package:davetcim/shared/models/reservation_model.dart';
import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';

import '../shared/models/corporate_sessions_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/all_reservation/all_reservation_corporate_landing_view.dart';
import '../src/admin_corporate_panel/all_reservation/all_reservation_corporate_view.dart';
import '../src/admin_corporate_panel/all_reservation/all_reservation_corporate_view_model.dart';
import 'modal_content/info_modal_content.dart';

class CartReservationAdminUpdateItem extends StatefulWidget {
  final ReservationModel reservationModel;
  final List<CorporateSessionsModel> sessionList;
  final int index;

  CartReservationAdminUpdateItem(
      {Key key,
      @required this.reservationModel,
      @required this.sessionList,
      @required this.index
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
    int reservationStatusFlag = 0;
    if (widget.sessionList[widget.index].hasReservation) {
      color = Colors.red;
      reserveInfo = "Rezerve Edilmiştir";
      reservationStatusFlag = 1;
    } else if (DateConversionUtils.isOldDate(DateConversionUtils.getDateTimeFromIntDate(
        widget.reservationModel.date))) {
      color = Colors.grey;
      reserveInfo = "Bu seansın süresi doldu";
      reservationStatusFlag = 2;
    }

      return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: InkWell(
        onTap: ()  {
          if (reservationStatusFlag == 1) {
            InfoModalContent.showInfoModalContent(
                context,
                "Tarih Seçim Uyarısı",
                "Bu seans rezerve edilmiştir", null);
          } else if (reservationStatusFlag == 2) {
            InfoModalContent.showInfoModalContent(
                context,
                "Tarih Seçim Uyarısı",
                "Geçmiş tarihli rezervasyon yapılamaz", null);
          } else {
            widget.reservationModel.sessionId = widget.sessionList[widget.index].id;
            widget.reservationModel.sessionName = widget.sessionList[widget.index].name;
            widget.reservationModel.sessionCost = widget.sessionList[widget.index].midweekPrice;
            if(DateConversionUtils.isWeekendFromIntDate(widget.reservationModel.date) ){
              widget.reservationModel.sessionCost = widget.sessionList[widget.index].weekendPrice;
            }

            AllReservationCorporateViewModel allReservationCorporateViewModel = AllReservationCorporateViewModel();
            allReservationCorporateViewModel.delayReservation(context, widget.reservationModel);
            Utils.navigateToPage(context, AllReservationLandingView(pageIndex: 1));

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
