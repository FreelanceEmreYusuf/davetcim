import 'package:davetcim/src/reservation/reservation_view_model.dart';
import 'package:davetcim/widgets/empty_reservation_list.dart';
import 'package:davetcim/widgets/grid_reservation.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/screens/notifications.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../../screens/notifications.dart';
import '../../shared/dto/basket_user_model.dart';
import '../../shared/environments/const.dart';
import '../../shared/models/corporate_sessions_model.dart';
import '../../shared/models/reservation_model.dart';
import '../../shared/utils/date_utils.dart';
import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/cart_reservation_item.dart';
import '../../widgets/on_error/somethingWentWrong.dart';

class ReservationOrderViewScreen extends StatefulWidget {
  @override
  _ReservationOrderViewScreenState createState() => _ReservationOrderViewScreenState();

  final BasketUserModel basketModel;
  const ReservationOrderViewScreen(this.basketModel);
}

class _ReservationOrderViewScreenState extends State<ReservationOrderViewScreen>  {

  List<CorporateSessionsModel> reservationList = [];

  @override
  void initState() {
    callGetReservationList();

  }

  void callGetReservationList() async {
    ReservationViewModel rvm = ReservationViewModel();
    reservationList = await rvm.getSessionReservationExtraction(widget.basketModel.corporationId,
        widget.basketModel.date);

    setState(() {
      reservationList = reservationList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 20;
    if (reservationList == null || reservationList.length == 0) {
      return Scaffold(
        appBar: AppBarMenu(pageName: DateConversionUtils.getDateTimeFromIntDate(widget.basketModel.date).toString().substring(0,10), isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      );
    }
    return Scaffold(
      appBar: AppBarMenu(pageName: DateConversionUtils.getDateTimeFromIntDate(widget.basketModel.date).toString().substring(0,10), isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.0,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 5,
            mainAxisExtent: MediaQuery.of(context).size.height / 4.7,
          ),
          itemCount: reservationList == null
              ? 0
              : reservationList.length,
          itemBuilder: (BuildContext context, int index) {
            CorporateSessionsModel item = reservationList[index];
            widget.basketModel.sessionModel = item;
            return CartReservationItem(basketModel: widget.basketModel, reservationList: reservationList, index: index);
          },
        ),
      ),

    );
  }
}
