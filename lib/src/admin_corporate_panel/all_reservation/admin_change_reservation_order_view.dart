import 'package:davetcim/src/reservation/reservation_view_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/corporate_sessions_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/cart_reservation_admin_update_item.dart';

class AdminChangeReservationOrderViewScreen extends StatefulWidget {
  @override
  _AdminChangeReservationOrderViewScreenState createState() => _AdminChangeReservationOrderViewScreenState();

  final  ReservationModel reservationModel;
  final  int date;
  const AdminChangeReservationOrderViewScreen(this.reservationModel, this.date);
}

class _AdminChangeReservationOrderViewScreenState extends State<AdminChangeReservationOrderViewScreen>  {

  List<CorporateSessionsModel> sessionList = [];

  @override
  void initState() {
    callGetReservationList();

  }

  void callGetReservationList() async {
    ReservationViewModel rvm = ReservationViewModel();
    sessionList = await rvm.getSessionReservationExtractionForUpdate(widget.reservationModel.corporationId,
        widget.date, widget.reservationModel.sessionId,
        widget.reservationModel.customerId
    );

    setState(() {
      sessionList = sessionList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 20;
    if (sessionList == null || sessionList.length == 0) {
      return Scaffold(
        appBar: AppBarMenu(pageName: DateConversionUtils.getDateTimeFromIntDate(widget.date).toString().substring(0,10), isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      );
    }
    return Scaffold(
      appBar: AppBarMenu(pageName: DateConversionUtils.getDateTimeFromIntDate(widget.date).toString().substring(0,10), isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
          itemCount: sessionList == null
              ? 0
              : sessionList.length,
          itemBuilder: (BuildContext context, int index) {
            widget.reservationModel.date = widget.date;
            return CartReservationAdminUpdateItem(reservationModel: widget.reservationModel,
                sessionList: sessionList, index: index);
          },
        ),
      ),

    );
  }
}
