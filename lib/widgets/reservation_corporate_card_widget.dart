import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Container(
      child: InkWell(
        onTap: (){
          Utils.navigateToPage(context, ReservationCorporateDetailScreen(reservationModel : widget.model));
        },
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white54,
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
                  Text(DateConversionUtils.convertIntTimeToViewString(widget.model.date),
                    style: TextStyle(overflow: TextOverflow.ellipsis,   fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.bold,),
                    maxLines: 5,
                  ),
                  Expanded(
                    child: Text("\n\n Davet Türü : " + widget.model.invitationType + "\n Davetli Sayısı : " + widget.model.invitationCount.toString() +
                        "\n Toplam Ücret : " + widget.model.cost.toString()+" TL",
                      style: TextStyle(overflow: TextOverflow.ellipsis,   fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold,),
                      maxLines: 5,
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
