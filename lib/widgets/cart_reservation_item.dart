import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/src/products/product_detail_view.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

import '../shared/dto/basket_user_model.dart';
import '../shared/models/corporate_sessions_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/profile/profile_view.dart';
import '../src/reservation/reservation_view_model.dart';
import '../src/select-orders/properties/order_view.dart';

class CartReservationItem extends StatefulWidget {
  final BasketUserModel basketModel;

  CartReservationItem(
      {Key key,
      @required this.basketModel,})
      : super(key: key);

  @override
  State<CartReservationItem> createState() => _CartReservationItemState();
}

class _CartReservationItemState extends State<CartReservationItem> {

  void navigateToBasket()  {
    Utils.navigateToPage(context, OrderScreen(basketModel: widget.basketModel));
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String reserveInfo = "Bu Seans Müsait";
    int reservationStatusFlag = 0;
    if (widget.basketModel.sessionModel.hasReservation) {
      color = Colors.red;
      reserveInfo = "Rezerve Edilmiştir";
      reservationStatusFlag = 1;
    } else if (DateConversionUtils.isOldDate(DateConversionUtils.getDateTimeFromIntDate(
        widget.basketModel.date))) {
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
                  widget.basketModel.sessionModel.name,
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
