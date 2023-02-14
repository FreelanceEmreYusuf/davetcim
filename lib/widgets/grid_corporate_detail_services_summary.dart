import 'package:davetcim/shared/sessions/user_basket_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/dto/basket_user_model.dart';
import '../shared/dto/reservation_detail_view_model.dart';
import '../shared/models/reservation_detail_model.dart';
import '../shared/models/service_corporate_pool_model.dart';
import '../shared/models/service_pool_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/language.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import '../src/admin_corporate_panel/service/service-corporate_view_model.dart';
import '../src/admin_corporate_panel/service/service_corporate_add_view.dart';
import '../src/admin_corporate_panel/service/service_corporate_update_view.dart';
import '../src/admin_corporate_panel/service/service_corporate_view.dart';

class GridCorporateDetailServicesSummary extends StatefulWidget {
  final ReservationDetailModel detailRowModel;
  final ReservationDetailViewModel detailModel;


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
