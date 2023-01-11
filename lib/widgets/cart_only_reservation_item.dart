import 'package:flutter/material.dart';
import 'package:davetcim/src/products/product_detail_view.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

import '../shared/models/corporate_sessions_model.dart';
import '../shared/models/reservation_model.dart';
import '../src/reservation/reservation_view_model.dart';

class CartOnlyReservationItem extends StatefulWidget {
  final ReservationModel item;

  CartOnlyReservationItem(
      {Key key,
      @required this.item,})
      : super(key: key);

  @override
  State<CartOnlyReservationItem> createState() => _CartOnlyReservationItemState();
}

class _CartOnlyReservationItemState extends State<CartOnlyReservationItem> {

  CorporateSessionsModel sessionModel =
    new CorporateSessionsModel(id : 0, corporationId : 0, name : "", midweekPrice : 0,weekendPrice : 0);

  @override
  void initState() {
    getSessionData();
  }

  void getSessionData() async {
    ReservationViewModel rvm = ReservationViewModel();
    sessionModel = await rvm.getSessionDetail(widget.item.sessionId);

    setState(() {
      sessionModel = sessionModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Card(
        elevation: 8.0,
        child: ListView(
          children: <Widget>[
            ListTile(
              subtitle: Text("Rezerve Edilmiştir"),
              title: Text(
                sessionModel.name,
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
