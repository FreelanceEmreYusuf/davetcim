import 'package:davetcim/src/reservation/reservation_view_model.dart';
import 'package:davetcim/widgets/grid_reservation.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/screens/notifications.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../../screens/notifications.dart';
import '../../shared/environments/const.dart';
import '../../shared/models/reservation_model.dart';
import '../widgets/on_error/somethingWentWrong.dart';

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

                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                      icon: Icon(
                        Icons.keyboard_backspace,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    centerTitle: true,
                    title: Text(
                      "Rezervasyon Bilgileri (" + widget.dateTime.toString() + ")",
                    ),
                    elevation: 0.0,
                    actions: <Widget>[
                      IconButton(
                        icon: IconBadge(
                          icon: Icons.notifications,
                          size: 22.0,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Notifications();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                    body: Container(

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                        child: ListView(
                          children: <Widget>[
                            GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1.0,
                                crossAxisSpacing: 0.0,
                                mainAxisSpacing: 5,
                                mainAxisExtent: 264,
                              ),
                              itemCount: reservationList == null
                                  ? 0
                                  : reservationList.length,
                              itemBuilder: (BuildContext context, int index) {
                                ReservationModel item = reservationList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                             //       height: 50,
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(

                                      textColor: Colors.white,
                                      child: GridReservation(startTime :item.startTime, endTime: item.endTime),
                                    ));
                              },
                            ),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ),

                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })


    );
  }
}
