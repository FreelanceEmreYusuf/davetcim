import 'package:davetcim/shared/sessions/reservation_edit_state.dart';
import 'package:davetcim/src/reservation/reservation_view_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/corporate_sessions_model.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/user_reservation_update_cart_reservation_item.dart';


class UserReservationUpdateReservationOrderViewScreen extends StatefulWidget {
  @override
  _UserReservationUpdateReservationOrderViewScreenState createState() => _UserReservationUpdateReservationOrderViewScreenState();
}

class _UserReservationUpdateReservationOrderViewScreenState extends State<UserReservationUpdateReservationOrderViewScreen>  {

  List<CorporateSessionsModel> sessionList = [];

  @override
  void initState() {
    callGetReservationList();

  }

  void callGetReservationList() async {
    ReservationViewModel rvm = ReservationViewModel();
    sessionList = await rvm.getSessionReservationExtractionForUpdate(
        ReservationEditState.reservationDetail.corporateModel.corporationId,
        ReservationEditState.reservationDetail.reservationModel.date,
        ReservationEditState.reservationDetail.reservationModel.sessionId,
        ReservationEditState.reservationDetail.reservationModel.customerId
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
        appBar: AppBarMenu(pageName: DateConversionUtils.getDateTimeFromIntDate(
            ReservationEditState.reservationDetail.reservationModel.date).toString().substring(0,10),
            isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      );
    }
    return Scaffold(
      appBar: AppBarMenu(pageName: DateConversionUtils.getDateTimeFromIntDate(
          ReservationEditState.reservationDetail.reservationModel.date).toString().substring(0,10),
          isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
            return UserReservationUpdateCartReservationItem(
                sessionList: sessionList, index: index);
          },
        ),
      ),

    );
  }
}
