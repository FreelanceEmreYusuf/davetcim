import 'package:davetcim/src/join/forgotPasswd/reset_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).accentColor,
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Colors.grey,
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
              text: "Şifremi Unuttum",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ResetPasswordView(),
        ],
      ),
    );
  }
}
