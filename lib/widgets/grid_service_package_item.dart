import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/dto/basket_user_dto.dart';
import '../shared/enums/corporation_service_selection_enum.dart';
import '../shared/models/corporation_package_services_model.dart';
import '../shared/sessions/user_basket_session.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/select-orders/services/services_view.dart';
import '../src/select-orders/summary_basket/summary_basket_view.dart';

class GridServicePackageItem extends StatefulWidget {
  final CorporationPackageServicesModel packageModel;
  final BasketUserDto basketModel;

  GridServicePackageItem({
    Key key,
    @required this.packageModel,
    @required this.basketModel,
  }) : super(key: key);

  @override
  _GridServicePackageItemState createState() =>
      _GridServicePackageItemState();
}

class _GridServicePackageItemState
    extends State<GridServicePackageItem> {
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
                            "\nDavetli Sayısı("+widget.basketModel.orderBasketModel.count.toString()+") "
                            "\nKişi Başı Paket Ücreti("+widget.packageModel.price.toString()+"TL)"
                            "\nToplam Ücret: "+(widget.packageModel.price*widget.basketModel.orderBasketModel.count).toString()+" TL",
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
                  widget.basketModel.packageModel = widget.packageModel;
                  if (widget.basketModel.corporationModel.serviceSelection ==
                      CorporationServiceSelectionEnum.customerSelectsExtraProduct
                  || widget.basketModel.corporationModel.serviceSelection ==
                      CorporationServiceSelectionEnum.customerSelectsBoth) {
                    Utils.navigateToPage(context, ServicesScreen(basketModel: widget.basketModel));
                  } else {
                    Utils.navigateToPage(context, SummaryBasketScreen(basketModel: widget.basketModel));
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