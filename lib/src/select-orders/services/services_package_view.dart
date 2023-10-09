import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../shared/models/corporation_package_services_model.dart';
import '../../../shared/dto/basket_user_dto.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_service_package_item.dart';


class ServicesPackageView extends StatefulWidget {
  final BasketUserDto basketModel;

  ServicesPackageView(
      {Key key,
        @required this.basketModel,
      })
      : super(key: key);

  @override
  _ServicesPackageViewState createState() =>
      _ServicesPackageViewState();
}

class _ServicesPackageViewState extends State<ServicesPackageView> {

  List<CorporationPackageServicesModel> packagesList = [];
  bool hasDataTaken = false;

  @override
  void initState() {
    super.initState();
    fillPackegeList();
  }

  void fillPackegeList() async  {
    ServiceCorporatePackageViewModel packageViewModel = ServiceCorporatePackageViewModel();
    packagesList = await packageViewModel.getPackageList(widget.basketModel.corporationModel.corporationId);

    setState(() {
      packagesList = packagesList;
      hasDataTaken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Paketler",  isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: CircularProgressIndicator())));
    }

    return Scaffold(
      appBar: AppBarMenu(pageName: "Paketler", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
                return GridServicePackageItem(packageModel: item, basketModel: widget.basketModel,);
              },
            ),
          ],
        ),
      ),
    );
  }
}
