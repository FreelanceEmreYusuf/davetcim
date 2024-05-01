import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/models/corporation_model.dart';
import '../shared/utils/utils.dart';
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
    Color buttonColor = Colors.grey;
    if (!widget.corporationModel.isActive) {
      buttonText = 'Aktif Yap';
      buttonColor = Colors.green;
    }

    String buttonTextForPopular = 'Normal Yap';
    Color buttonColorForPopular = Colors.deepOrangeAccent;
    if (!widget.corporationModel.isPopularCorporation) {
      buttonTextForPopular = 'Popular Yap';
      buttonColorForPopular = Colors.redAccent;
    }

    row = Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(3.0,0,0,0),
            child: Text(
                widget.corporationModel.corporationName, style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold)),
          ),
        ),
        Expanded(
          flex: 1,
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
        Expanded(
          flex: 1,
          child: ClipPath(
            child: Material(
              color: buttonColorForPopular, // button color
              child: InkWell(
                splashColor: Colors.deepOrangeAccent, // splash color
                onTap: () async {
                  await updateCorporationPopularity(widget.corporationModel);
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.whatshot, color: Colors.white), // icon
                    Text(buttonTextForPopular, style: TextStyle(color: Colors.white)),
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
          //color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 13,
            child: Card(
              color: Colors.white12,
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

  Future<void> updateCorporationPopularity(CorporationModel corporationModel) async {
    CorporationActivePassiveViewModel editCorporationPopularity = CorporationActivePassiveViewModel();
    await editCorporationPopularity.editCorporationPopularity(corporationModel);
    Utils.navigateToPage(context, CorporationActivePassiveView());
  }

}
