import 'package:flutter/material.dart';

import '../shared/enums/reservation_status_enum.dart';
import '../shared/models/corporate_sessions_model.dart';
import '../shared/models/reservation_model.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/all_reservation/all_reservation_corporate_detail_view.dart';
import '../src/reservation/reservation_view_model.dart';

class CartOnlyReservationItem extends StatefulWidget {
  final ReservationModel item;

  CartOnlyReservationItem(
      {Key key,
      @required this.item,})
      : super(key: key);

  @override
  State<CartOnlyReservationItem> createState() => _CartOnlyReservationItemState();
}

class _CartOnlyReservationItemState extends State<CartOnlyReservationItem> {

  CorporateSessionsModel sessionModel =
    new CorporateSessionsModel(id : 0, corporationId : 0, name : "", midweekPrice : 0,weekendPrice : 0);

  @override
  void initState() {
    getSessionData();
  }

  void getSessionData() async {
    ReservationViewModel rvm = ReservationViewModel();
    sessionModel = await rvm.getSessionDetail(widget.item.sessionId);

    setState(() {
      sessionModel = sessionModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.blueAccent;
    String subtitleText = "Teklif Oluşturuldu";
    if (widget.item.reservationStatus == ReservationStatusEnum.userOffer) {
      color = Colors.lightBlueAccent;
    } else if (widget.item.reservationStatus == ReservationStatusEnum.preReservation) {
      subtitleText = "Opsiyonlandı";
      color = Colors.blueAccent;
    } else if (widget.item.reservationStatus == ReservationStatusEnum.reservation) {
      subtitleText = "Rezerve Edilmiştir";
      color = Colors.green;
    }

    final currentContext = context;

    return Container(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
          child: Scaffold(
            body: Column(
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  child: ListTile(
                    title: Text(
                      sessionModel.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    subtitle: Text(subtitleText),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Utils.navigateToPage(
                          currentContext,
                          AllReservationCorporateDetailScreen(reservationModel: widget.item),
                        );
                      },
                      child: Text('Detay'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
