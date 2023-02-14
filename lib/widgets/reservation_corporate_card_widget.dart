import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/models/corporate_sessions_model.dart';
import '../shared/models/reservation_model.dart';
import '../shared/utils/date_utils.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/language.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/reservation/reservation_corporate_detail_view.dart';
import '../src/admin_corporate_panel/seans/seans_corporate_update_view.dart';
import '../src/admin_corporate_panel/seans/seans_corporate_view.dart';
import '../src/admin_corporate_panel/seans/seans_corporate_view_model.dart';

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
      height: MediaQuery.of(context).size.height / 1.25,

      child: InkWell(
        onTap: (){
          Utils.navigateToPage(context, ReservationCorporateDetailScreen(reservationModel : widget.model));
        },

        child: Card(

          color: Colors.white54,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shadowColor: Colors.black,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(DateConversionUtils.convertIntTimeToViewString(widget.model.date) +
              "\n Davet Türü : " + widget.model.invitationType + "\n Davetli Sayısı : " + widget.model.invitationCount.toString() +
              "\n Toplam Ücret : " + widget.model.cost.toString(),
            style: TextStyle(overflow: TextOverflow.ellipsis,   fontSize: 15, color: Colors.black, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,),
            maxLines: 5,
          ),
        ),
      )


    );
  }

}
