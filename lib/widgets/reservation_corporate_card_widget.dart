import 'package:davetcim/shared/enums/reservation_status_enum.dart';
import 'package:flutter/material.dart';
import '../shared/helpers/general_helper.dart';
import '../shared/models/reservation_model.dart';
import '../shared/utils/date_utils.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/reservation/reservation_corporate_detail_view.dart';

class ReservationCorporateCardWidget extends StatefulWidget {
  final  ReservationModel model;

  ReservationCorporateCardWidget({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  _ReservationCorporateCardWidgetState createState() =>
      _ReservationCorporateCardWidgetState();
}

class _ReservationCorporateCardWidgetState
    extends State<ReservationCorporateCardWidget> {
  @override
  Widget build(BuildContext context) {
    Color rowColor = Colors.white54;
    if (widget.model.reservationStatus == ReservationStatusEnum.userOffer) {
      rowColor = Colors.lightBlueAccent;
    } else  if (widget.model.reservationStatus == ReservationStatusEnum.preReservation) {
      rowColor = Colors.blueAccent;
    } else  if (widget.model.reservationStatus == ReservationStatusEnum.reservation) {
      rowColor = Colors.green;
    } else  {
      rowColor = Colors.redAccent;
    }

    return Container(
      padding: EdgeInsets.fromLTRB(3.0, 1, 3, 10),
      child: InkWell(
        onTap: (){
          Utils.navigateToPage(context, ReservationCorporateDetailScreen(
              reservationModel : widget.model, isFromNotification: false));
        },
        child: Card(
          color: rowColor,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shadowColor: Colors.black,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(DateConversionUtils.convertIntTimeToViewString(widget.model.date),
                    style: TextStyle(overflow: TextOverflow.ellipsis,   fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.bold,),
                    maxLines: 5,
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text("\n\n Geçen Gün Sayısı : " +  DateConversionUtils.getDayDifferenceFromToday(widget.model.recordDate).toString()  +
                        "\n Davet Türü : " + widget.model.invitationType +
                        "\n Davetli Sayısı : " + widget.model.invitationCount.toString() +
                        "\n Toplam Ücret : " + GeneralHelper.formatMoney(widget.model.cost.toString())+" TL",
                      style: TextStyle(overflow: TextOverflow.ellipsis,   fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold,),
                      maxLines: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
