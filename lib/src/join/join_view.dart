import 'package:davetcim/src/join/corporation_register/corporation_register_view.dart';
import 'package:davetcim/src/join/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/src/join/register/register_view.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../../shared/utils/utils.dart';
import '../main/main_screen_view.dart';

class JoinView extends StatefulWidget {
  final Widget childPage;
  JoinView({
    Key key,
    this.childPage,
  }) : super(key: key);
  @override
  _JoinViewState createState() => _JoinViewState();
}

class _JoinViewState extends State<JoinView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);
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
          onPressed: () => Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight)),
        ),
        elevation: 8.0,
        title: IconButton(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/1.4),
          icon: Icon(
            Icons.home,
          ),
          onPressed: () {
            Utils.navigateToPage(context, MainScreen());
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          labelStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
          tabs: <Widget>[
            FittedBox(
              child: Tab(
                text: "Giriş Yap",
              ),
            ),
            FittedBox(
              child: Tab( 
                text: "Kayıt Ol",
              ),
            ),
            FittedBox(
              child: Tab(
                text: "Salon Kayıt",
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          LoginView(childPage: widget.childPage,),
          RegisterView(),
          CorporationRegisterView(),
        ],
      ),
    );
  }
}
