import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/basket_user_model.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/sessions/user_basket_session.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_corporate_service_pool_for_basket.dart';
import '../../../widgets/grid_corporate_service_pool_for_basket_summary.dart';
import '../../admin_corporate_panel/service/service-corporate_view_model.dart';
import '../../notifications/notifications_view_model.dart';

class SummaryBasketScreen extends StatefulWidget {
  @override
  _SummaryBasketScreenState createState() => _SummaryBasketScreenState();
  final BasketUserModel basketModel;

  SummaryBasketScreen(
      {Key key,
        @required this.basketModel,
      })
      : super(key: key);

}

class _SummaryBasketScreenState extends State<SummaryBasketScreen>
    with AutomaticKeepAliveClientMixin<SummaryBasketScreen> {

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
      appBar: AppBarMenu(pageName: "Sepet Özeti", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
              itemCount: widget.basketModel.servicePoolModel == null
                  ? 0
                  : widget.basketModel.servicePoolModel.length,
              itemBuilder: (BuildContext context, int index) {
                ServicePoolModel item = widget.basketModel.servicePoolModel[index];

                return GridCorporateServicePoolForBasketSummary(servicePoolModel: item, basketModel: widget.basketModel,);
              },
            ),
            SizedBox(height: 10.0),
            Card(

              elevation: 10,
              color: Colors.white54,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      "Toplam Tutar :", style: TextStyle(fontSize: 20, color: Colors.black, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,)),
                 SizedBox(width: MediaQuery.of(context).size.width /4),
                  Text(
                      "999999TL", style: TextStyle(fontSize: 20, color: Colors.red, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, )),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(5.0),
        height: 50.0,
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.redAccent,),
          child: Text(
            "SEPETİ ONAYLA",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
           widget.basketModel.servicePoolModel = UserBasketSession.servicePoolModel;
           UserBasketSession.servicePoolModel = [];
           NotificationsViewModel notificationViewModel = NotificationsViewModel();
           notificationViewModel.sendNotificationsToAdminCompanyUsers(context, widget.basketModel.corporationId, 0, "Yeni bir rezervasyon talebiniz var");
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
