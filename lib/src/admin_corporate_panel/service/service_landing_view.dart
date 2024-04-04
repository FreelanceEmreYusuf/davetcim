import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_user_choose/service_corporate_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_provider.dart';
import '../../../shared/environments/const.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/bounce_button.dart';
import '../AdminCorporatePanel.dart';

class ServiceLandingView extends StatefulWidget {
  final int pageIndex;
  ServiceLandingView({
    Key key,
    this.pageIndex,
  }) : super(key: key);
  @override
  _ServiceLandingViewState createState() => _ServiceLandingViewState();
}

class _ServiceLandingViewState extends State<ServiceLandingView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    _tabController.index = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title: FittedBox(
          child: BounceButton(
            child: Text(
              "Salon Hizmet İşlemleri",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xffffffff),
                fontWeight: FontWeight.w700,
                fontFamily: 'RobotoMono',
              ),
            ),
            onTap: (){

            },
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                color: Provider.of<AppProvider>(context).theme ==
                    Constants.lightTheme
                    ? Colors.redAccent
                    : Constants.darkAccent,
                borderRadius: BorderRadius.circular(50)
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => {
            Utils.navigateToPage(context, AdminCorporatePanelPage()),
          },
        ),
        elevation: 8.0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          labelStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          tabs: <Widget>[
            FittedBox(
              child: Tab(
                text: "Havuzdan Hizmet Ekle",
              ),
            ),
            FittedBox(
              child: Tab(
                text: "Hizmet Paketi Oluştur",
              )
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          AdminCorporateServicePoolManager(),
          ServiceCorporatePackageView(),
        ],
      ),
    );
  }
}
