import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/dto/basket_user_dto.dart';
import '../shared/enums/corporation_service_selection_enum.dart';
import '../shared/models/corporation_package_services_model.dart';
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
      children: [
        Expanded(
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
                color: Colors.yellow, // button color
                child: InkWell(
                  splashColor: Colors.deepOrangeAccent, // splash color
                  onTap: () async {
                    Dialogs.showAlertMessageWithAction(
                        context,
                        widget.packageModel.title,
                        widget.packageModel.body,
                        null);
                  }, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.info, color: Colors.white), // icon
                      Text("Bilgi", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        Spacer(),
        Expanded(
          child: ClipPath(
            child: Material(
              color: Colors.green, // button color
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
              child: row,
              elevation: 10,
            ),
          ),
        ],
      ),
    );
  }
}
