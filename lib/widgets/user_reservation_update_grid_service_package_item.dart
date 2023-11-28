import 'package:davetcim/widgets/user_reservation_update_grid_corporate_service_pool_for_basket_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/dto/reservation_detail_view_dto.dart';
import '../shared/enums/corporation_service_selection_enum.dart';
import '../shared/models/corporation_package_services_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/user_reservations/update/user_reservation_update_services_view.dart';

class UserReservationUpdateGridServicePackageItem extends StatefulWidget {
  final CorporationPackageServicesModel packageModel;
  final ReservationDetailViewDto detailResponse;

  UserReservationUpdateGridServicePackageItem({
    Key key,
    @required this.packageModel,
    @required this.detailResponse,
  }) : super(key: key);

  @override
  _UserReservationUpdateGridServicePackageItemState createState() =>
      _UserReservationUpdateGridServicePackageItemState();
}

class _UserReservationUpdateGridServicePackageItemState
    extends State<UserReservationUpdateGridServicePackageItem> {
  @override
  Widget build(BuildContext context) {
    Row row;

    row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
              widget.packageModel.title, style: TextStyle(
              fontSize: 18,
              color: Colors.green,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold)),
        ),
        Spacer(),
        Expanded(
            child: ClipPath(
              child: Material(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0)),
                color: Colors.grey, // button color
                child: InkWell(
                  splashColor: Colors.deepOrangeAccent, // splash color
                  onTap: () async {
                    Dialogs.showAlertMessageWithAction(
                        context,
                        widget.packageModel.title,
                        "Paket İçeriği: "+widget.packageModel.body+""
                        "\n\nKişi başı ücret: "+widget.packageModel.price.toString()+" TL"
                            "\n\nDavetli Sayısına Göre Toplam Tutar: "
                            "\nDavetli Sayısı("+widget.detailResponse.orderBasketModel.count.toString()+") "
                            "\nKişi Başı Paket Ücreti("+widget.packageModel.price.toString()+"TL)"
                            "\nToplam Ücret: "+(widget.packageModel.price*widget.detailResponse.orderBasketModel.count).toString()+" TL",
                        null);
                  }, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FittedBox(child: Icon(Icons.info, color: Colors.white)), // icon
                      FittedBox(child: Text("Bilgi", style: TextStyle(color: Colors.white))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        Expanded(
          child: ClipPath(
            child: Material(
              color: Colors.green, // button color
              borderRadius: BorderRadius.horizontal(right: Radius.circular(30.0)),
              child: InkWell(
                splashColor: Colors.deepOrangeAccent, // splash color
                onTap: () {
                  widget.detailResponse.packageModel = widget.packageModel;
                  if (widget.detailResponse.corporateModel.serviceSelection ==
                      CorporationServiceSelectionEnum.customerSelectsExtraProduct
                  || widget.detailResponse.corporateModel.serviceSelection ==
                      CorporationServiceSelectionEnum.customerSelectsBoth) {
                    Utils.navigateToPage(context, UserReservationUpdateServicesScreen(detailResponse: widget.detailResponse));
                  } else {
                    Utils.navigateToPage(context, UserReservationUpdateGridCorporateServicePoolForBasketSummary(detailResponse: widget.detailResponse));
                  }
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.select_all, color: Colors.white), // icon
                    Text("Seç", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Container(
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: row, // Burada row widgetını kullanmalısınız.
              elevation: 10,
            ),
          ),
        ],
      ),
    );
  }
}
