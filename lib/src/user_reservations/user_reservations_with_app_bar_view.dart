import 'package:davetcim/src/user_reservations/user_reservations_view_model.dart';
import 'package:flutter/material.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/app_bar/app_bar_view_with_back_home_page.dart';
import '../../widgets/app_bar/app_bar_without_previous_icon_view.dart';
import '../../widgets/reservation_user_card_widget.dart';
import '../main/main_screen_view.dart';


class UserReservationsWithAppBarScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<UserReservationsWithAppBarScreen> {
  List<ReservationModel> reservationList = [];
  final registerFormKey = GlobalKey <FormState> ();

  @override
  void initState() {
    callGetReservations();
    super.initState();
  }

  void callGetReservations() async {
    UserReservationsViewModel model = UserReservationsViewModel();
    reservationList = await model.getReservationlist();

    setState(() {
      reservationList = reservationList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Geri tuşuna basıldığında MainScreen'a git
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
              (Route<dynamic> route) => false,
        );
        return true; // Geri tuşunun işleme devam etmesini sağlar
      },
      child: Scaffold(
        appBar: AppBarMenuBackToHomePage(pageName: 'Rezervasyonlar', isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              Divider(),
              SizedBox(height: 10.0),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 5),
                ),
                itemCount: reservationList == null
                    ? 0
                    : reservationList.length,
                itemBuilder: (BuildContext context, int index) {
                  ReservationModel item = reservationList[index];
                  return ReservationUserCardWidget(model: item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

