import 'package:davetcim/src/admin_corporate_panel/other_user_reservation/summary_basket_new_user_view.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/service_pool_model.dart';
import '../../../shared/sessions/user_basket_state.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/indicator.dart';
import '../service/service_corporate_user_choose/service-corporate_view_model.dart';
import 'grid_corporate_service_pool_new_user_for_basket.dart';

class ServicesNewUserScreen extends StatefulWidget {
  @override
  _ServicesNewUserScreenState createState() => _ServicesNewUserScreenState();
}

class _ServicesNewUserScreenState extends State<ServicesNewUserScreen>
    with AutomaticKeepAliveClientMixin<ServicesNewUserScreen> {

  List<ServicePoolModel> serviceList;
  bool hasDataTaken = false;

  @override
  void initState() {
    super.initState();
    setServiceList();
  }

  void setServiceList() async {
    ServiceCorporatePoolViewModel model = ServiceCorporatePoolViewModel();
    serviceList = updateServiceList(await model.getServiceList(
        UserBasketState.userBasket.corporationModel.corporationId));

    if (serviceList.length == 0) {
      navigateToNextScreen();
    }

    setState(() {
      serviceList = serviceList;
      hasDataTaken = true;
    });
  }

  void navigateToNextScreen() {
    Utils.navigateToPage(context, SummaryBasketNewUserScreen());
  }

  List<ServicePoolModel> updateServiceList(List<ServicePoolModel> serviceList){
    for(int i=0; i<serviceList.length; i++){
          serviceList.removeWhere((item) => item.companyHasService == false && item.hasChild != true);
    }
    return serviceList;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Hizmetler",  isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: Indicator())));
    }

    return Scaffold(
      appBar: AppBarMenu(pageName: "Hizmetler", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
          padding: EdgeInsets.fromLTRB(10.0, 10, 10.0, 10),
          child: ListView(
            children: <Widget>[
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 12),
                ),
                itemCount: serviceList == null
                    ? 0
                    : serviceList.length,
                itemBuilder: (BuildContext context, int index) {
                  ServicePoolModel item = serviceList[index];
                  return GridCorporateServicePoolNewUserForBasket(servicePoolModel: item);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(5.0),
        height: 50.0,
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.redAccent,),
          child: Text(
            "DEVAM ET",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            UserBasketState.userBasket.servicePoolModel = UserBasketState.servicePoolModel;
           navigateToNextScreen();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
