import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/models/generic_lookup_item_model.dart';
import '../shared/utils/utils.dart';
import '../src/admin_panel/manage_lookups/manage_lookups_add_view.dart';
import '../src/admin_panel/manage_lookups/manage_lookups_edit_view.dart';

class GridLookupItem extends StatefulWidget {
  final GenericLookupItemModel lookupModel;
  final String dbTable;

  GridLookupItem({
    Key key,
    @required this.lookupModel,
    @required this.dbTable,
  }) : super(key: key);

  @override
  _GridLookupItemState createState() =>
      _GridLookupItemState();
}

class _GridLookupItemState
    extends State<GridLookupItem> {
  @override
  Widget build(BuildContext context) {
    Row row;

    row = Row(
      children: [
        Expanded(
          child: Text(
              widget.lookupModel.name, style: TextStyle(
              fontSize: 18,
              color: Colors.green,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold)),
        ),
        Spacer(),
        Expanded(
            child: ClipPath(
              child: Material(
                color: Colors.green, // button color
                child: InkWell(
                  splashColor: Colors.deepOrangeAccent, // splash color
                  onTap: () async {
                    Utils.navigateToPage(context, LookupUpdateView(
                      genericLookupItemModel: widget.lookupModel, dbTable: widget.dbTable));
                  }, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.update, color: Colors.white), // icon
                      Text("Güncelle", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        Expanded(
          child: ClipPath(
            child: Material(
              color: Colors.blueAccent, // button color
              child: InkWell(
                splashColor: Colors.deepOrangeAccent, // splash color
                onTap: () async {
                  Utils.navigateToPage(context, LookupAddView(dbTable: widget.dbTable));
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.whatshot, color: Colors.white), // icon
                    Text("Ekle", style: TextStyle(color: Colors.white)),
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
