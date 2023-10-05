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
                      Icon(Icons.update, color: Colors.white), // icon
                      Text("Güncelle", style: TextStyle(color: Colors.white)),
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
                    Icon(Icons.delete, color: Colors.white), // icon
                    Text("Sil", style: TextStyle(color: Colors.white)),
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
