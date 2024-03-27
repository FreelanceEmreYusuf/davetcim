import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    if (widget.model.reservationStatus == ReservationStatusEnum.adminRejected) {
      color = Colors.redAccent;
      textColor = Colors.white;
    } else if (widget.model.reservationStatus == ReservationStatusEnum.approved) {
      color = Colors.green;
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
                  Text(
                    DateConversionUtils.convertIntTimeToViewString(widget.model.date),
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 5,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Davet Türü:',
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
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Davetli Sayısı:',
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Toplam Ücret:',
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
