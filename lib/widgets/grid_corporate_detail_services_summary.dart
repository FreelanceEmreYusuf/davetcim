import 'package:davetcim/shared/sessions/reservation_edit_state.dart';
import 'package:flutter/material.dart';
import '../shared/helpers/general_helper.dart';
import '../shared/models/reservation_detail_model.dart';
import 'modal_content/info_modal_content.dart';

class GridCorporateDetailServicesSummary extends StatefulWidget {
  final ReservationDetailModel detailRowModel;

  GridCorporateDetailServicesSummary({
    Key key,
    @required this.detailRowModel
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

    if (!widget.detailRowModel.priceChangedForCount) {
      priceChangeForCount = "Hayır";
    }

    row = Row(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
              widget.detailRowModel.serviceName.replaceAll("-", ""), style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
        ),
        Spacer(),
        SizedBox.fromSize(
          size: Size(MediaQuery.of(context).size.height / 10, MediaQuery.of(context).size.height / 10), // button width and height
          child: ClipPath(
            child: Material(
              color: Colors.grey, // button color
              child: InkWell(
                splashColor: Colors.deepOrangeAccent, // splash color
                onTap: () async {
                  InfoModalContent.showInfoModalContent(
                      context,
                      widget.detailRowModel.serviceName,
                      //TODO: hizmet için fiyat bilgileri girilecek
                      "Belirtmiş olduğunuz davetli sayısı : " +
                          ReservationEditState.reservationDetail.reservationModel.invitationCount.toString()
                          +"\n\nÜcret kişi sayısına bağlı değişir mi? : "+ priceChangeForCount
                          +"\n\nHizmetin birim ücreti : "+ GeneralHelper.formatMoney(widget.detailRowModel.price.toString()),
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
          color: Colors.transparent,
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
