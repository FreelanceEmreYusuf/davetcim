import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/models/corporation_package_services_model.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_edit_view.dart';
import '../src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view_model.dart';
import '../src/admin_corporate_panel/service/service_landing_view.dart';

class GridPackageItem extends StatefulWidget {
  final CorporationPackageServicesModel packageModel;

  GridPackageItem({
    Key key,
    @required this.packageModel
  }) : super(key: key);

  @override
  _GridPackageItemState createState() =>
      _GridPackageItemState();
}

class _GridPackageItemState
    extends State<GridPackageItem> {
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
            padding: const EdgeInsets.all(8.0),
            child: Text(
                widget.packageModel.title, style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold)),
          ),
        ),
        Spacer(),
        Expanded(
          flex: 1,
            child: ClipPath(
              child: Material(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(5.0)),
                color: Colors.green, // button color
                child: InkWell(
                  splashColor: Colors.deepOrangeAccent, // splash color
                  onTap: () async {
                    Utils.navigateToPage(context, ServiceCorporatePackageEditView(
                      packageModel: widget.packageModel
                    ));
                  }, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: Icon(Icons.update, color: Colors.white)), // icon
                      Expanded(child: Text("Güncelle", style: TextStyle(color: Colors.white))),
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
              color: Colors.red, // button color
              child: InkWell(
                splashColor: Colors.redAccent, // splash color
                onTap: () async {
                  ServiceCorporatePackageViewModel model = ServiceCorporatePackageViewModel();
                  await model.deactivatePackageItem(widget.packageModel);
                  Utils.navigateToPage(context, ServiceLandingView(pageIndex: 1));
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: Icon(Icons.delete, color: Colors.white)), // icon
                    Expanded(child: Text("Sil", style: TextStyle(color: Colors.white))),
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
