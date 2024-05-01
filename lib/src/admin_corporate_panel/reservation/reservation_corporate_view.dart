import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import 'package:flutter/material.dart';
import '../../../shared/environments/const.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/sessions/user_state.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/indicator.dart';
import '../../../widgets/no_found_notification_screen.dart';
import '../../../widgets/reservation_corporate_card_widget.dart';

class ReservationCorporateView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ReservationCorporateView> {
  List<ReservationModel> reservationList = [];
  bool hasDataTaken = false;
  final registerFormKey = GlobalKey <FormState> ();

  @override
  void initState() {
    callGetReservations();
    super.initState();
  }

  void callGetReservations() async {
    ReservationCorporateViewModel model = ReservationCorporateViewModel();
    reservationList = await model.getReservationlist(UserState.corporationId);

    setState(() {
      reservationList = reservationList;
      hasDataTaken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Aktif Talepler", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: Indicator())));
    }
    if(reservationList.length>0 && reservationList.isNotEmpty){
      return Scaffold(
        appBar: AppBarMenu(pageName: "Aktif Talepler", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
                    return ReservationCorporateCardWidget(model: item);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
    else{
      return Scaffold(
        appBar: AppBarMenu(pageName: "Aktif Talepler", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
            padding: const EdgeInsets.all(10.0),
            child: NoFoundDataScreen(keyText: "Rezervasyon bulunamadı"),
          ),
        ),
      );

    }
  }
}

