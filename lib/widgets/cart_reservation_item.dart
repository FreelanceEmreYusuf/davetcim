import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';

import '../shared/enums/reservation_status_enum.dart';
import '../shared/sessions/user_basket_state.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/select-orders/properties/order_view.dart';

class CartReservationItem extends StatefulWidget {
  @override
  State<CartReservationItem> createState() => _CartReservationItemState();
}

class _CartReservationItemState extends State<CartReservationItem> {

  void navigateToBasket()  {
    Utils.navigateToPage(context, OrderScreen());
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String reserveInfo = "Bu Seans Müsait";
    int reservationStatusFlag = 0;
    if (UserBasketState.userBasket.sessionModel.hasReservation) {
      reservationStatusFlag = 1;
      if (UserBasketState.userBasket.sessionModel.reservationStatus ==
          ReservationStatusEnum.userOffer) {
        reserveInfo = "Teklif Oluşturuldu";
        color = Colors.lightBlueAccent;
      } else if (UserBasketState.userBasket.sessionModel.reservationStatus ==
          ReservationStatusEnum.preReservation) {
        reserveInfo = "Opsiyonlandı";
        color = Colors.blueAccent;
      } else if (UserBasketState.userBasket.sessionModel.reservationStatus ==
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
                  UserBasketState.userBasket.sessionModel.name,
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
