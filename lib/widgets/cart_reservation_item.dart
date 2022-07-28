import 'package:flutter/material.dart';
import 'package:davetcim/src/products/product_detail_view.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

class CartReservationItem extends StatelessWidget {
  final String startTime;
  final String endTime;

  CartReservationItem(
      {Key key,
      @required this.startTime,
      @required this.endTime,})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Card(
        elevation: 8.0,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                "Başlangıç Saati :" + "$startTime",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            ListTile(
              title: Text(
                "Bitiş Saati :" + "$endTime",
                style: TextStyle(
                  fontSize: 15,
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
