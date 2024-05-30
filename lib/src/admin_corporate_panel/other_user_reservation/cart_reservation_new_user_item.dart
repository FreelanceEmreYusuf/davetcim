import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';

import '../../../shared/enums/reservation_status_enum.dart';
import '../../../shared/models/corporate_sessions_model.dart';
import '../../../shared/sessions/user_basket_state.dart';
import '../../../shared/utils/dialogs.dart';
import '../../../shared/utils/utils.dart';
import 'order_new_user_view.dart';

class CartReservationNewUserItem extends StatefulWidget {
  final  CorporateSessionsModel sessionModel;
  const CartReservationNewUserItem(this.sessionModel);

  @override
  State<CartReservationNewUserItem> createState() => _CartReservationNewUserItemState();
}

class _CartReservationNewUserItemState extends State<CartReservationNewUserItem> {

  void navigateToBasket()  {
    Utils.navigateToPage(context, OrderNewUserScreen());
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String reserveInfo = "Bu Seans Müsait";
    int reservationStatusFlag = 0;
    if (widget.sessionModel.hasReservation) {
      reservationStatusFlag = 1;
      if (widget.sessionModel.reservationStatus ==
          ReservationStatusEnum.userOffer) {
        reserveInfo = "Teklif Oluşturuldu";
        color = Colors.lightBlueAccent;
      } else if (widget.sessionModel.reservationStatus ==
          ReservationStatusEnum.preReservation) {
        reserveInfo = "Opsiyonlandı";
        color = Colors.blueAccent;
      } else if (widget.sessionModel.reservationStatus ==
          ReservationStatusEnum.reservation) {
        reserveInfo = "Satış Oluşturuldu";
        color = Colors.redAccent;
      }
    } else if (DateConversionUtils.isOldDate(DateConversionUtils.getDateTimeFromIntDate(
        UserBasketState.userBasket.date))) {
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
                "Geçmiş tarihli teklif oluşturulamaz", null);
          } else {
            UserBasketState.userBasket.sessionModel = widget.sessionModel;
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
                  widget.sessionModel.name,
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
