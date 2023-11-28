import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view_model.dart';
import 'package:davetcim/src/user_reservations/update/user_reservation_update_services_view.dart';
import 'package:davetcim/src/user_reservations/update/user_reservation_update_summary_basket_view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/models/corporation_package_services_model.dart';
import '../../../shared/dto/reservation_detail_view_dto.dart';
import '../../../shared/enums/corporation_service_selection_enum.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/user_reservation_update_grid_service_package_item.dart';


class UserReservationUpdateServicesPackageView extends StatefulWidget {
  final ReservationDetailViewDto detailResponse;

  UserReservationUpdateServicesPackageView(
      {Key key,
        @required this.detailResponse,
      })
      : super(key: key);

  @override
  _UserReservationUpdateServicesPackageViewState createState() =>
      _UserReservationUpdateServicesPackageViewState();
}

class _UserReservationUpdateServicesPackageViewState extends State<UserReservationUpdateServicesPackageView> {

  List<CorporationPackageServicesModel> packagesList = [];
  bool hasDataTaken = false;

  @override
  void initState() {
    super.initState();
    fillPackegeList();
  }

  void fillPackegeList() async  {
    ServiceCorporatePackageViewModel packageViewModel = ServiceCorporatePackageViewModel();
    packagesList = await packageViewModel.getPackageList(widget.detailResponse.corporateModel.corporationId);

    if (packagesList.length == 0) {
      navigateToNextScreen();
    }

    setState(() {
      packagesList = packagesList;
      hasDataTaken = true;
    });
  }

  void navigateToNextScreen() {
    widget.detailResponse.packageModel = null;
    if (widget.detailResponse.corporateModel.serviceSelection ==
        CorporationServiceSelectionEnum.customerSelectsExtraProduct
        || widget.detailResponse.corporateModel.serviceSelection ==
            CorporationServiceSelectionEnum.customerSelectsBoth) {
      Utils.navigateToPage(context, UserReservationUpdateServicesScreen(detailResponse: widget.detailResponse));
    } else {
      Utils.navigateToPage(context, UserReservationUpdateSummaryBasketScreen(detailResponse: widget.detailResponse));
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
                return UserReservationUpdateGridServicePackageItem(packageModel: item, detailResponse: widget.detailResponse,);
              },
            ),
          ],
        ),
      ),
    );
  }
}
