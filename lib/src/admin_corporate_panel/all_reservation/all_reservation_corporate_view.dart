import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/sessions/user_state.dart';
import '../../../widgets/indicator.dart';
import '../../../widgets/on_error/somethingWentWrong.dart';
import '../../../widgets/reservation_all_corporate_card_widget.dart';
import 'all_reservation_corporate_view_model.dart';

class AllReservationCorporateView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<AllReservationCorporateView> {
  final registerFormKey = GlobalKey <FormState> ();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllReservationCorporateViewModel>(
        create: (_)=>AllReservationCorporateViewModel(),
        builder: (context,child) => StreamBuilder<List<ReservationModel>>(
            stream: Provider.of<AllReservationCorporateViewModel>(context, listen: false)
                .getOnlineAllReservationlist(UserState.corporationId),
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return SomethingWentWrongScreen();
              } else if (asyncSnapshot.hasData) {
                List<ReservationModel> reservationList = asyncSnapshot.data;
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
              } else {
                return Center(
                  child: Indicator(),
                );
              }
            })
    );
  }
}

