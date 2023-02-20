import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_add_view.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_view_model.dart';
import 'package:flutter/material.dart';
import '../../../shared/models/corporate_sessions_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/reservation_all_corporate_card_widget.dart';
import '../../../widgets/reservation_corporate_card_widget.dart';
import '../../../widgets/seans_corporate_card_widget.dart';
import '../../reservation/reservation_view_model.dart';
import 'all_reservation_corporate_view_model.dart';


class AllReservationCorporateView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<AllReservationCorporateView> {
  List<ReservationModel> reservationList = [];
  final registerFormKey = GlobalKey <FormState> ();

  @override
  void initState() {
    callGetReservations();
    super.initState();
  }

  void callGetReservations() async {
    AllReservationCorporateViewModel model = AllReservationCorporateViewModel();
    reservationList = await model.getAllReservationlist(ApplicationSession.userSession.corporationId);

    setState(() {
      reservationList = reservationList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(pageName: "Tüm Rezervasyonlar", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
                return ReservationAllCorporateCardWidget(model: item);
              },
            ),
          ],
        ),
      ),
    );
  }
}

