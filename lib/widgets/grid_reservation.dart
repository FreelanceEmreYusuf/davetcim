import 'package:davetcim/widgets/cart_reservation_item.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/src/products/product_detail_view.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

import '../shared/utils/date_utils.dart';

class GridReservation extends StatelessWidget {
  final int startTime;
  final int endTime;
  final DateTime dateTime;

  GridReservation(
      {Key key,
        this.startTime,
        this.endTime,
        this.dateTime,
      })
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
              title: Expanded(
                child: Text(
                  "Başlangıç Saati :" + DateConversionUtils.convertIntTimeToString(startTime),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ListTile(
              title: Expanded(
                child: Text(
                  "Bitiş Saati :" + DateConversionUtils.convertIntTimeToString(endTime),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}