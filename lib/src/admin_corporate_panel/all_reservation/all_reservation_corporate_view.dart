import 'package:flutter/material.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/sessions/user_state.dart';
import '../../../widgets/reservation_all_corporate_card_widget.dart';
import 'all_reservation_corporate_view_model.dart';

class AllReservationCorporateView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<AllReservationCorporateView> {
  final registerFormKey = GlobalKey <FormState> ();

  List<ReservationModel> reservationList = [];
  bool hasDataTaken = false;


  @override
  void initState() {
    super.initState();
    callGetReservations();
  }

  void callGetReservations() async {
    AllReservationCorporateViewModel model = AllReservationCorporateViewModel();
    reservationList = await model.getAllReservationlist(UserState.corporationId);

    setState(() {
      reservationList = reservationList;
      hasDataTaken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasDataTaken) {
      return Scaffold(body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: CircularProgressIndicator())));
    }

    return Scaffold(
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

