import 'package:davetcim/shared/sessions/application_context.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_add_view.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../shared/models/corporation_package_services_model.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../widgets/grid_package_item.dart';


class ServiceCorporatePackageView extends StatefulWidget {

  @override
  _ServiceCorporatePackageViewState createState() =>
      _ServiceCorporatePackageViewState();
}

class _ServiceCorporatePackageViewState extends State<ServiceCorporatePackageView> {

  List<CorporationPackageServicesModel> packagesList = [];

  @override
  void initState() {
    super.initState();
    fillPackegeList();
  }

  void fillPackegeList() async  {
    ServiceCorporatePackageViewModel packageViewModel = ServiceCorporatePackageViewModel();
    packagesList = await packageViewModel.getPackageList(ApplicationContext.userCache.corporationId);

    setState(() {
      packagesList = packagesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           Utils.navigateToPage(context, ServiceCorporatePackageAddView());
        },
        label: Text('Yeni Ekle', style: TextStyle(fontSize: 15), maxLines: 2),
        icon: Icon(Icons.add_circle),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Divider(),
            SizedBox(height: 10.0),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 12),
              ),
              itemCount: packagesList == null
                  ? 0
                  : packagesList.length,
              itemBuilder: (BuildContext context, int index) {
                CorporationPackageServicesModel item = packagesList[index];

                return GridPackageItem(packageModel: item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
