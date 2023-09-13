import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/models/corporation_model.dart';
import '../shared/models/service_corporate_pool_model.dart';
import '../shared/models/service_pool_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/language.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/service/service-corporate_view_model.dart';
import '../src/admin_corporate_panel/service/service_corporate_add_view.dart';
import '../src/admin_corporate_panel/service/service_corporate_update_view.dart';
import '../src/admin_corporate_panel/service/service_corporate_view.dart';
import '../src/admin_panel/manage_corporation_active_passive/corporation_active_passive_view.dart';
import '../src/admin_panel/manage_corporation_active_passive/corporation_active_passive_view_model.dart';

class GridCorporateActivePassive extends StatefulWidget {
  final CorporationModel corporationModel;

  GridCorporateActivePassive({
    Key key,
    @required this.corporationModel,
  }) : super(key: key);

  @override
  _GridCorporateActivePassiveState createState() =>
      _GridCorporateActivePassiveState();
}

class _GridCorporateActivePassiveState
    extends State<GridCorporateActivePassive> {
  @override
  Widget build(BuildContext context) {
    Row row;

    String buttonText = 'Pasif Yap';
    Color buttonColor = Colors.blue;
    if (!widget.corporationModel.isActive) {
      buttonText = 'Aktif Yap';
      buttonColor = Colors.green;
    }

    row = Row(
      children: [
        Text(
            widget.corporationModel.corporationName, style: TextStyle(
            fontSize: 18,
            color: Colors.green,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold)),
        Spacer(),
        SizedBox.fromSize(
          size: Size(MediaQuery
              .of(context)
              .size
              .height / 10, MediaQuery
              .of(context)
              .size
              .height / 10), // button width and height
          child: ClipPath(
            child: Material(
              color: buttonColor, // button color
              child: InkWell(
                splashColor: Colors.deepOrangeAccent, // splash color
                onTap: () async {
                  await updateCorporationActivePassive(widget.corporationModel);
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.update, color: Colors.white), // icon
                    Text(buttonText, style: TextStyle(color: Colors.white)),
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
  Future<void> updateCorporationActivePassive(CorporationModel corporationModel) async {
    CorporationActivePassiveViewModel corporationActivePassiveViewModel = CorporationActivePassiveViewModel();
    await corporationActivePassiveViewModel.editCorporationActivePassive(corporationModel);
    Utils.navigateToPage(context, CorporationActivePassiveView());
  }

}
