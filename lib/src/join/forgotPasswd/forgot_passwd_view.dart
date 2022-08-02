import 'package:davetcim/src/join/forgotPasswd/reset_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../widgets/app_bar/app_bar_view.dart';

class ForgotPasswdView extends StatefulWidget {
  @override
  _ForgotPasswdViewState createState() => _ForgotPasswdViewState();
}

class _ForgotPasswdViewState extends State<ForgotPasswdView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 1);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(pageName: "Şifremi Unuttum", isHomnePageIconVisible: true, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ResetPasswordView(),
        ],
      ),
    );
  }
}
