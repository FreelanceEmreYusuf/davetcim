import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../shared/enums/reservation_status_enum.dart';
import '../shared/helpers/general_helper.dart';
import '../shared/models/reservation_model.dart';
import '../shared/utils/date_utils.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/all_reservation/all_reservation_corporate_detail_view.dart';
import '../src/admin_corporate_panel/reservation/reservation_corporate_detail_view.dart';
import '../src/user_reservations/user_reservation_detail_view.dart';

class ReservationUserCardWidget extends StatefulWidget {
  final ReservationModel model;

  ReservationUserCardWidget({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  _ReservationUserCardWidgetState createState() =>
      _ReservationUserCardWidgetState();
}

class _ReservationUserCardWidgetState
    extends State<ReservationUserCardWidget> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.white54;
    Color textColor = Colors.black;
    if (widget.model.reservationStatus == ReservationStatusEnum.adminRejectedOffer) {
      color = Colors.redAccent;
      textColor = Colors.white;
    } else if (widget.model.reservationStatus == ReservationStatusEnum.reservation) {
      color = Colors.green;
      textColor = Colors.white;
    } else if (widget.model.reservationStatus == ReservationStatusEnum.preReservation) {
      color = Colors.blueAccent;
      textColor = Colors.white;
    } else if (widget.model.reservationStatus == ReservationStatusEnum.userOffer) {
      color = Colors.yellowAccent;
      textColor = Colors.white;
    }

    return Container(
      child: InkWell(
        onTap: () {
          Utils.navigateToPage(
              context,
              UserResevationDetailScreen(
                  reservationModel: widget.model, isFromNotification: false));
        },
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Card(
            color: color,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.black,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        DateConversionUtils.convertIntTimeToViewString(widget.model.date),
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 5,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          children: [
                            Text(
                              'Davet Türü',
                              style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.model.invitationType,
                              style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Davetli Sayısı',
                              style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.model.invitationCount.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ücret',
                              style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${GeneralHelper.formatMoney(widget.model.cost.toString())} TL',
                              style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
