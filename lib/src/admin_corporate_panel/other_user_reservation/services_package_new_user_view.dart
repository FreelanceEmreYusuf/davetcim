import 'package:davetcim/src/admin_corporate_panel/other_user_reservation/services_new_user_view.dart';
import 'package:davetcim/src/admin_corporate_panel/other_user_reservation/summary_basket_new_user_view.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../shared/models/corporation_package_services_model.dart';
import '../../../shared/enums/corporation_service_selection_enum.dart';
import '../../../shared/sessions/user_basket_state.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/indicator.dart';
import 'grid_service_package_new_user_tem.dart';

class ServicesPackageNewUserView extends StatefulWidget {

  @override
  _ServicesPackageNewUserViewState createState() =>
      _ServicesPackageNewUserViewState();
}

class _ServicesPackageNewUserViewState extends State<ServicesPackageNewUserView> {

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
      Utils.navigateToPage(context, ServicesNewUserScreen());
    } else {
      Utils.navigateToPage(context, SummaryBasketNewUserScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Paketler",  isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: Indicator())));
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/filter_page_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.1), // Filtre yoğunluğu
            ],
          ),
        ),
        child: Padding(
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
                  return GridServicePackageNewUserItem(packageModel: item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
