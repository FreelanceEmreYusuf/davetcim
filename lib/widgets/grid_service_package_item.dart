import 'package:flutter/material.dart';
import '../shared/enums/corporation_service_selection_enum.dart';
import '../shared/helpers/general_helper.dart';
import '../shared/models/corporation_package_services_model.dart';
import '../shared/sessions/user_basket_state.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/select-orders/services/services_view.dart';
import '../src/select-orders/summary_basket/summary_basket_view.dart';
import 'expanded_card_widget.dart';

class GridServicePackageItem extends StatefulWidget {
  final CorporationPackageServicesModel packageModel;

  GridServicePackageItem({
    Key key,
    @required this.packageModel,
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
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 0, 0.0, 0),
            child: Text(
                widget.packageModel.title, style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold)),
          ),
        ),
        Expanded(
          flex: 1,
          child: ClipPath(
            child: Material(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(5.0)),
              color: Colors.grey, // button color
              child: InkWell(
                splashColor: Colors.deepOrangeAccent, // splash color
                onTap: () async {
                  Dialogs.showInfoModalContent(
                      context,
                      widget.packageModel.title,
                      "Paket İçeriği: "+widget.packageModel.body+""
                      "\n\nKişi başı ücret: "+GeneralHelper.formatMoney(widget.packageModel.price.toString())+" TL"
                          "\n\nDavetli Sayısına Göre Toplam Tutar: "
                          "\nDavetli Sayısı("+UserBasketState.userBasket.orderBasketModel.count.toString()+") "
                          "\nKişi Başı Paket Ücreti("+GeneralHelper.formatMoney(widget.packageModel.price.toString())+"TL)"
                          "\nToplam Ücret: "+GeneralHelper.formatMoney((widget.packageModel.price * UserBasketState.userBasket.orderBasketModel.count).toString())+" TL",
                      null);
                }, // button pressed
                child: Column(
                  children: <Widget>[
                    Expanded(child: Icon(Icons.info, color: Colors.white)), // icon
                    Expanded(child: Text("Bilgi", style: TextStyle(color: Colors.white))), 
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ClipPath(
            child: Material(
              color: Colors.green, // button color
              borderRadius: BorderRadius.horizontal(right: Radius.circular(5.0)),
              child: InkWell(
                splashColor: Colors.deepOrangeAccent, // splash color
                onTap: () {
                  UserBasketState.userBasket.packageModel = widget.packageModel;
                  if (UserBasketState.userBasket.corporationModel.serviceSelection ==
                      CorporationServiceSelectionEnum.customerSelectsExtraProduct
                  || UserBasketState.userBasket.corporationModel.serviceSelection ==
                      CorporationServiceSelectionEnum.customerSelectsBoth) {
                    Utils.navigateToPage(context, ServicesScreen());
                  } else {
                    Utils.navigateToPage(context, SummaryBasketScreen());
                  }
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: Icon(Icons.select_all, color: Colors.white)), // icon
                    Expanded(child: Text("Seç", style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Container(
      child: Card(
        color: Colors.white54,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
          ),
        ),
        child: row, // Burada row widgetını kullanmalısınız.
        elevation: 10,
      ),
    );
  }
}
