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
      @required this.startTime,
      @required this.endTime,
      @required this.dateTime,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CartReservationItem(startTime: DateConversionUtils.convertIntTimeToString(startTime),
          endTime: DateConversionUtils.convertIntTimeToString(endTime));
  }
}
