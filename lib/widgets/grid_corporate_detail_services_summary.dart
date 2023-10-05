import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/dto/reservation_detail_view_dto.dart';
import '../shared/models/reservation_detail_model.dart';
import '../shared/utils/dialogs.dart';

class GridCorporateDetailServicesSummary extends StatefulWidget {
  final ReservationDetailModel detailRowModel;
  final ReservationDetailViewDto detailModel;


  GridCorporateDetailServicesSummary({
    Key key,
    @required this.detailRowModel,
    @required this.detailModel,
  }) : super(key: key);

  @override
  _GridCorporateDetailServicesSummaryState createState() =>
      _GridCorporateDetailServicesSummaryState();
}

class _GridCorporateDetailServicesSummaryState
    extends State<GridCorporateDetailServicesSummary> {

  bool buffer = true;
  String priceChangeForCount = "Evet";
  IconData buttonIcon = Icons.add;
  @override
  Widget build(BuildContext context) {
    double _paddingLeftValue = 0;

    Row row;

    if (!widget.detailRowModel.servicePoolModel.corporateDetail.priceChangedForCount) {
      priceChangeForCount = "Hayır";
    }

    row = Row(
      children: [
        Text(
            widget.detailRowModel.servicePoolModel.serviceName.replaceAll("-", ""), style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
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
                      widget.detailRowModel.servicePoolModel.serviceName,
                      //TODO: hizmet için fiyat bilgileri girilecek
                      "Belirtmiş olduğunuz davetli sayısı : "+widget.detailModel.reservationModel.invitationCount.toString()
                          +"\n\nÜcret kişi sayısına bağlı değişir mi? : "+ priceChangeForCount
                          +"\n\nHizmetin birim ücreti : "+ widget.detailRowModel.servicePoolModel.corporateDetail.price.toString(),
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
