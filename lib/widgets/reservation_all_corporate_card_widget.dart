import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/enums/reservation_status_enum.dart';
import '../shared/models/reservation_model.dart';
import '../shared/utils/date_utils.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/all_reservation/all_reservation_corporate_detail_view.dart';
import '../src/admin_corporate_panel/reservation/reservation_corporate_detail_view.dart';

class ReservationAllCorporateCardWidget extends StatefulWidget {
  final  ReservationModel model;

  ReservationAllCorporateCardWidget({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  _ReservationAllCorporateCardWidgetState createState() =>
      _ReservationAllCorporateCardWidgetState();
}

class _ReservationAllCorporateCardWidgetState
    extends State<ReservationAllCorporateCardWidget> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    if (widget.model.reservationStatus == ReservationStatusEnum.adminRejected) {
      color = Colors.redAccent;
    }

    return Container(
      child: InkWell(
        onTap: (){
          Utils.navigateToPage(context, AllReservationCorporateDetailScreen(reservationModel : widget.model));
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(DateConversionUtils.convertIntTimeToViewString(widget.model.date),
                      style: TextStyle(overflow: TextOverflow.ellipsis,   fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,),
                      maxLines: 5,
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("\n\n Davet Türü : " + widget.model.invitationType + "\n Davetli Sayısı : " + widget.model.invitationCount.toString() +
                          "\n Toplam Ücret : " + widget.model.cost.toString()+" TL",
                        style: TextStyle(overflow: TextOverflow.ellipsis,   fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold,),
                        maxLines: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

}
