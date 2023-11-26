import 'package:davetcim/shared/sessions/application_cache.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_add_view.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_view_model.dart';
import 'package:flutter/material.dart';
import '../../../shared/environments/const.dart';
import '../../../shared/models/corporate_sessions_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/reservation_corporate_card_widget.dart';
import '../../../widgets/seans_corporate_card_widget.dart';
import '../../reservation/reservation_view_model.dart';


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
    reservationList = await model.getReservationlist(ApplicationCache.userCache.corporationId);

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
              child: Center(child: CircularProgressIndicator())));
    }
    if(reservationList.length>0 && reservationList.isNotEmpty){
      return Scaffold(
        appBar: AppBarMenu(pageName: "Aktif Talepler", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
                  return ReservationCorporateCardWidget(model: item);
                },
              ),
            ],
          ),
        ),
      );
    }
    else{
      return Scaffold(
        appBar: AppBarMenu(pageName: "Aktif Talepler", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Aktif rezervasyon bulunamadı',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white60,
                      fontStyle: FontStyle.italic,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(10.0, 10.0),
                          blurRadius: 2.0,
                          color: Colors.black54,
                        ),
                        Shadow(
                          offset: Offset(10.0, 10.0),
                          blurRadius: 1.0,
                          color: Colors.black54,
                        ),
                      ],
                      fontFamily: 'RobotoMono',
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
                color: Constants.lightPrimary,
              ),
            )),
      );
    }

  }
}

