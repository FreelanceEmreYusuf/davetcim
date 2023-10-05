import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_user_choose/service_corporate_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/utils/utils.dart';
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
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Tab(
              text: "Firma Ekstra Ürünler",
            ),
            Tab(
              text: "Firma Paketleri",
            )
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
