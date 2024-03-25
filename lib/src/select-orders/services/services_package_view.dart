import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view_model.dart';
import 'package:davetcim/src/select-orders/services/services_view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/models/corporation_package_services_model.dart';
import '../../../shared/enums/corporation_service_selection_enum.dart';
import '../../../shared/sessions/user_basket_state.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_service_package_item.dart';
import '../summary_basket/summary_basket_view.dart';

class ServicesPackageView extends StatefulWidget {

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
    packagesList = await packageViewModel.getPackageList(
        UserBasketState.userBasket.corporationModel.corporationId);

    if (packagesList.length == 0) {
      navigateToNextScreen();
    }

    setState(() {
      packagesList = packagesList;
      hasDataTaken = true;
    });
  }

  void navigateToNextScreen() {
    UserBasketState.userBasket.packageModel = null;
    if (UserBasketState.userBasket.corporationModel.serviceSelection ==
        CorporationServiceSelectionEnum.customerSelectsExtraProduct
        || UserBasketState.userBasket.corporationModel.serviceSelection ==
            CorporationServiceSelectionEnum.customerSelectsBoth) {
      Utils.navigateToPage(context, ServicesScreen());
    } else {
      Utils.navigateToPage(context, SummaryBasketScreen());
    }
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateToNextScreen();
        },
        label: Text('Seçmeden Devam Et', style: TextStyle(fontSize: 15), maxLines: 2),
        icon: Icon(Icons.skip_next),
        backgroundColor: Colors.redAccent,
      ),
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
                return GridServicePackageItem(packageModel: item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
