import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/dto/basket_user_dto.dart';
import '../shared/enums/corporation_service_selection_enum.dart';
import '../shared/models/corporation_package_services_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/select-orders/services/services_view.dart';
import '../src/select-orders/summary_basket/summary_basket_view.dart';

class GridServicePackageSummaryItem extends StatefulWidget {
  final BasketUserDto basketModel;

  GridServicePackageSummaryItem({
    Key key,
    @required this.basketModel,
  }) : super(key: key);

  @override
  _GridServicePackageSummaryItemState createState() =>
      _GridServicePackageSummaryItemState();
}

class _GridServicePackageSummaryItemState
    extends State<GridServicePackageSummaryItem> {
  @override
  Widget build(BuildContext context) {
    Row row;

    row = Row(
      children: [
        Expanded(
          child: Text(
              widget.basketModel.packageModel.title, style: TextStyle(
              fontSize: 18,
              color: Colors.green,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold)),
        ),
        Spacer(),
        Expanded(
            child: ClipPath(
              child: Material(
                color: Colors.grey, // button color
                child: InkWell(
                  splashColor: Colors.deepOrangeAccent, // splash color
                  onTap: () async {
                    Dialogs.showAlertMessageWithAction(
                        context,
                        widget.basketModel.packageModel.title,
                        widget.basketModel.packageModel.body +
                            " \nFiyat:" + widget.basketModel.packageModel.price.toString() + "TL",
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
