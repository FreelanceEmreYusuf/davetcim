import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/basket_user_dto.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/sessions/user_basket_session.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_corporate_service_pool_for_basket.dart';
import '../../admin_corporate_panel/service/service_corporate_user_choose/service-corporate_view_model.dart';
import '../summary_basket/summary_basket_view.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
  final BasketUserDto basketModel;

  ServicesScreen(
      {Key key,
        @required this.basketModel,
      })
      : super(key: key);

}

class _ServicesScreenState extends State<ServicesScreen>
    with AutomaticKeepAliveClientMixin<ServicesScreen> {

  List<ServicePoolModel> serviceList;

  @override
  void initState() {
    super.initState();
    setServiceList();
  }

  void setServiceList() async {
    ServiceCorporatePoolViewModel model = ServiceCorporatePoolViewModel();
    //serviceList = await model.getServiceList();
    serviceList = updateServiceList(await model.getServiceList(widget.basketModel.corporationId));
    setState(() {
      serviceList = serviceList;
    });
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

                return GridCorporateServicePoolForBasket(servicePoolModel: item, basketModel: widget.basketModel,);
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
           widget.basketModel.servicePoolModel = UserBasketSession.servicePoolModel;
           Utils.navigateToPage(context, SummaryBasketScreen(basketModel: widget.basketModel));
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
