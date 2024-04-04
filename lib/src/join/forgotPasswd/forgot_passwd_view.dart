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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Şifremi Unuttum"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
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
