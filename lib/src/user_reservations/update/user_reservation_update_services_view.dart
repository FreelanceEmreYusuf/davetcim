import 'package:davetcim/shared/sessions/reservation_edit_state.dart';
import 'package:davetcim/src/user_reservations/update/user_reservation_update_summary_basket_view.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/sessions/user_basket_state.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/indicator.dart';
import '../../../widgets/user_reservation_update_grid_corporate_service_pool_for_basket.dart';
import '../../admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import '../../admin_corporate_panel/service/service_corporate_user_choose/service-corporate_view_model.dart';

class UserReservationUpdateServicesScreen extends StatefulWidget {
  @override
  _UserReservationUpdateServicesScreenState createState() => _UserReservationUpdateServicesScreenState();
}

class _UserReservationUpdateServicesScreenState extends State<UserReservationUpdateServicesScreen>
    with AutomaticKeepAliveClientMixin<UserReservationUpdateServicesScreen> {

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
        ReservationEditState.reservationDetail.corporateModel.corporationId));

    if (serviceList.length == 0) {
      navigateToNextScreen();
    }

    List<int> selectedServicesIds = [];
    for (int i  = 0; i < ReservationEditState.reservationDetail.detailList.length; i++) {
      ReservationDetailModel detailModel = ReservationEditState.reservationDetail.detailList[i];
      selectedServicesIds.add(detailModel.foreignId);
    }

    ReservationCorporateViewModel reservationCorporateViewModel = ReservationCorporateViewModel();
    UserBasketState.servicePoolModel =
      await reservationCorporateViewModel.getServicePoolModelDetailedList(selectedServicesIds,
          ReservationEditState.reservationDetail.reservationModel);

    setState(() {
      serviceList = serviceList;
      hasDataTaken = true;
    });
  }

  void navigateToNextScreen() {
    Utils.navigateToPage(context, UserReservationUpdateSummaryBasketScreen());
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
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
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

                  return UserReservationUpdateGridCorporateServicePoolForBasket(
                    servicePoolModel: item);
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
            ReservationEditState.reservationDetail.servicePoolModel = UserBasketState.servicePoolModel;
           navigateToNextScreen();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
