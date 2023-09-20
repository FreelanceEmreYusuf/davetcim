import 'package:davetcim/src/admin_corporate_panel/service/service-corporate_view_model.dart';
import 'package:flutter/material.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/sessions/application_session.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_corporate_service_pool.dart';


class AdminCorporateServicePoolManager extends StatefulWidget {


  @override
  _AdminCorporateServicePoolManagerState createState() =>
      _AdminCorporateServicePoolManagerState();
}

class _AdminCorporateServicePoolManagerState extends State<AdminCorporateServicePoolManager> {
  List<ServicePoolModel> serviceList;

  @override
  void initState() {
    super.initState();
    setServiceList();
  }

  void setServiceList() async {
    ServiceCorporatePoolViewModel model = ServiceCorporatePoolViewModel();
    serviceList = await model.getServiceList(ApplicationSession.userSession.corporationId);

    setState(() {
      serviceList = serviceList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(pageName: "Salon Hizmet Havuzu", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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

                return GridCorporateServicePool(servicePoolModel: item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
