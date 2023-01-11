import 'package:davetcim/src/reservation/reservation_view_model.dart';
import 'package:davetcim/widgets/empty_reservation_list.dart';
import 'package:davetcim/widgets/grid_reservation.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/screens/notifications.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../../screens/notifications.dart';
import '../../shared/environments/const.dart';
import '../../shared/models/reservation_model.dart';
import '../../shared/utils/date_utils.dart';
import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/cart_only_reservation_item.dart';
import '../../widgets/cart_reservation_item.dart';
import '../../widgets/on_error/somethingWentWrong.dart';

class ReservationViewScreen extends StatefulWidget {
  @override
  _ReservationViewScreenState createState() => _ReservationViewScreenState();

  final int corporateId;
  final DateTime dateTime;
  const ReservationViewScreen(this.corporateId, this.dateTime);
}

class _ReservationViewScreenState extends State<ReservationViewScreen>  {


  @override
  Widget build(BuildContext context) {
    double fontSize = 20;
    return ChangeNotifierProvider<ReservationViewModel>(
        create: (_)=>ReservationViewModel(),
        builder: (context,child) => StreamBuilder<List<ReservationModel>>(
            stream: Provider.of<ReservationViewModel>(context, listen: false).
              getReservationStreamlist(widget.corporateId, widget.dateTime),
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return SomethingWentWrongScreen();
              } else if (asyncSnapshot.hasData) {
                List<ReservationModel> reservationList = asyncSnapshot.data;
                if (reservationList.length > 0) {
                  return Scaffold(
                    appBar: AppBarMenu(pageName: widget.dateTime.toString().substring(0,10), isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
                        itemCount: reservationList == null
                            ? 0
                            : reservationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          ReservationModel item = reservationList[index];
                          return CartOnlyReservationItem(item: item);
                        },
                      ),
                    ),

                  );
                } else {
                  return EmptyReservationList(widget.dateTime);
                }

              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })


    );
  }
}
