import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/dto/reservation_detail_view_dto.dart';
import '../shared/models/corporation_package_services_model.dart';
import '../shared/models/reservation_detail_model.dart';
import '../shared/utils/dialogs.dart';

class GridCorporateDetailPackageSummary extends StatefulWidget {
  final CorporationPackageServicesModel packageModel;
  final ReservationDetailViewDto detailModel;


  GridCorporateDetailPackageSummary({
    Key key,
    @required this.packageModel,
    @required this.detailModel,
  }) : super(key: key);

  @override
  _GridCorporateDetailPackageSummaryState createState() =>
      _GridCorporateDetailPackageSummaryState();
}

class _GridCorporateDetailPackageSummaryState
    extends State<GridCorporateDetailPackageSummary> {

  bool buffer = true;
  String priceChangeForCount = "Evet";
  IconData buttonIcon = Icons.add;
  @override
  Widget build(BuildContext context) {
    double _paddingLeftValue = 0;

    Row row;

    row = Row(
      children: [
        Text(
            widget.packageModel.title, style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
        Spacer(),
        SizedBox.fromSize(
          size: Size(MediaQuery.of(context).size.height / 10, MediaQuery.of(context).size.height / 10), // button width and height
          child: ClipPath(
            child: Material(
              color: Colors.grey, // button color
              child: InkWell(
                splashColor: Colors.deepOrangeAccent, // splash color
                onTap: () async {
                  Dialogs.showAlertMessageWithAction(
                      context,
                      widget.packageModel.title,
                      widget.packageModel.body + "\n\nBelirtmiş olduğunuz davetli sayısı : "+widget.detailModel.reservationModel.invitationCount.toString()
                          +"\n\nHizmetin birim ücreti : "+ widget.packageModel.price.toString()
                          +"\n\nHizmetin toplam ücreti : "+
                          (widget.packageModel.price * widget.detailModel.reservationModel.invitationCount).toString(),
                      null);
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.info_outline, color: Colors.white), // icon
                    Text("Bilgi", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );



    return Container(
      padding: EdgeInsets.only(left: _paddingLeftValue),
      decoration: BoxDecoration(
          color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 13,
            child: Card(
              color: Colors.white54,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: row,
              elevation: 10,
            ),
          ),
        ],
      ),
    );
  }
}
