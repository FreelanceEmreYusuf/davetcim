import 'package:davetcim/src/user_reservations/update/user_reservation_update_summary_basket_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/reservation_detail_view_dto.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/sessions/user_basket_cache.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/user_reservation_update_grid_corporate_service_pool_for_basket.dart';
import '../../admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import '../../admin_corporate_panel/service/service_corporate_user_choose/service-corporate_view_model.dart';

class UserReservationUpdateServicesScreen extends StatefulWidget {
  @override
  _UserReservationUpdateServicesScreenState createState() => _UserReservationUpdateServicesScreenState();
  final ReservationDetailViewDto detailResponse;

  UserReservationUpdateServicesScreen(
      {Key key,
        @required this.detailResponse,
      })
      : super(key: key);

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
    serviceList = updateServiceList(await model.getServiceList(widget.detailResponse.corporateModel.corporationId));

    if (serviceList.length == 0) {
      navigateToNextScreen();
    }

    List<int> selectedServicesIds = [];
    for (int i  = 0; i < widget.detailResponse.detailList.length; i++) {
      ReservationDetailModel detailModel = widget.detailResponse.detailList[i];
      selectedServicesIds.add(detailModel.foreignId);
    }

    ReservationCorporateViewModel reservationCorporateViewModel = ReservationCorporateViewModel();
    UserBasketCache.servicePoolModel =
      await reservationCorporateViewModel.getServicePoolModelDetailedList(selectedServicesIds,
          widget.detailResponse.reservationModel);

    setState(() {
      serviceList = serviceList;
      hasDataTaken = true;
    });
  }

  void navigateToNextScreen() {
    Utils.navigateToPage(context, UserReservationUpdateSummaryBasketScreen(detailResponse: widget.detailResponse));
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
              child: Center(child: CircularProgressIndicator())));
    }

    return Scaffold(
      appBar: AppBarMenu(pageName: "Hizmetler", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
              itemCount: serviceList == null
                  ? 0
                  : serviceList.length,
              itemBuilder: (BuildContext context, int index) {
                ServicePoolModel item = serviceList[index];

                return UserReservationUpdateGridCorporateServicePoolForBasket(servicePoolModel: item, detailResponse: widget.detailResponse,);
              },
            ),
          ],
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
           widget.detailResponse.servicePoolModel = UserBasketCache.servicePoolModel;
           navigateToNextScreen();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
