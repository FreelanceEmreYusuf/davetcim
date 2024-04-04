import 'package:davetcim/shared/sessions/user_basket_state.dart';
import 'package:davetcim/src/reservation/reservation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/models/corporate_sessions_model.dart';
import '../../shared/utils/date_utils.dart';
import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/cart_reservation_item.dart';

class ReservationOrderViewScreen extends StatefulWidget {
  @override
  _ReservationOrderViewScreenState createState() => _ReservationOrderViewScreenState();
}

class _ReservationOrderViewScreenState extends State<ReservationOrderViewScreen>  {

  List<CorporateSessionsModel> reservationList = [];

  @override
  void initState() {
    callGetReservationList();

  }

  void callGetReservationList() async {
    ReservationViewModel rvm = ReservationViewModel();
    reservationList = await rvm.getSessionReservationExtraction(UserBasketState.userBasket.corporationModel.corporationId,
        UserBasketState.userBasket.date);

    setState(() {
      reservationList = reservationList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 20;
    if (reservationList == null || reservationList.length == 0) {
      return Scaffold(
        appBar: AppBarMenu(pageName: DateConversionUtils.dateTimeToString(DateConversionUtils.getDateTimeFromIntDate(UserBasketState.userBasket.date)), isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      );
    }
   // UserBasketState.userBasket.reservationList =
    return Scaffold(
      appBar: AppBarMenu(pageName: DateConversionUtils.dateTimeToString(DateConversionUtils.getDateTimeFromIntDate(UserBasketState.userBasket.date)), isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/filter_page_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.1), // Filtre yoğunluğu
            ],
          ),
        ),
        child: Padding(
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
              UserBasketState.userBasket.sessionModel = item;
              UserBasketState.userBasket.selectedSessionModel = reservationList[index];
              return CartReservationItem();
            },
          ),
        ),
      ),
    );
  }
}
