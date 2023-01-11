import 'package:flutter/material.dart';
import 'package:davetcim/src/products/product_detail_view.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

import '../shared/models/corporate_sessions_model.dart';
import '../src/reservation/reservation_view_model.dart';

class CartReservationItem extends StatefulWidget {
  final CorporateSessionsModel item;

  CartReservationItem(
      {Key key,
      @required this.item,})
      : super(key: key);

  @override
  State<CartReservationItem> createState() => _CartReservationItemState();
}

class _CartReservationItemState extends State<CartReservationItem> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String reserveInfo = "Bu Seans Müsait";
    if (widget.item.hasReservation) {
      color = Colors.red;
      reserveInfo = "Rezerve Edilmiştir";
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Card(
        elevation: 8.0,
        child: ListView(
          children: <Widget>[
            ListTile(
              subtitle: Text(reserveInfo),
              title: Text(
                widget.item.name,
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
    );
  }
}
