import 'package:davetcim/src/user_reservations/user_reservations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/models/reservation_model.dart';
import '../../widgets/indicator.dart';
import '../../widgets/on_error/somethingWentWrong.dart';
import '../../widgets/reservation_user_card_widget.dart';


class UserReservationsScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<UserReservationsScreen> {
  final registerFormKey = GlobalKey <FormState> ();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserReservationsViewModel>(
        create: (_)=>UserReservationsViewModel(),
        builder: (context,child) => StreamBuilder<List<ReservationModel>>(
            stream: Provider.of<UserReservationsViewModel>(context, listen: false)
                .getOnlineReservationlist(),
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
                              mainAxisExtent: MediaQuery.of(context).size.height / 6,
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
              } else {
                return Center(
                  child: Indicator(),
                );
              }
            })
    );
  }
}

