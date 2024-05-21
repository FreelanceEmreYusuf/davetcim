import 'package:flutter/material.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/sessions/user_state.dart';
import '../../../widgets/indicator.dart';
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
              child: Center(child: Indicator())));
    }

    return Scaffold(
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
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 5,
                  mainAxisExtent: MediaQuery.of(context).size.height / 4.7,
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
      ),
    );
  }
}

