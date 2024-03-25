import 'package:flutter/material.dart';
import '../shared/sessions/user_basket_state.dart';
import '../shared/utils/dialogs.dart';

class GridServicePackageSummaryItem extends StatefulWidget {

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
              UserBasketState.userBasket.packageModel.title, style: TextStyle(
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
                        UserBasketState.userBasket.packageModel.title,
                        UserBasketState.userBasket.packageModel.body +
                            " \nFiyat:" + UserBasketState.userBasket.packageModel.price.toString() + "TL",
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
