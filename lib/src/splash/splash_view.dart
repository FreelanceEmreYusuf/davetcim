import 'dart:async';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/entrance_page/entrance_view.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/src/walkthrough/walkthrough_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:davetcim/src/walkthrough/walkthrough_view.dart';

import '../entrance_page/entrance_view_model.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() {
    return Timer(Duration(milliseconds: 2400), changeScreen);
  }

  changeScreen() async {
    WalkthroughViewModel rm = WalkthroughViewModel();
    if (!await rm.willDemoShowed()) {
      Utils.navigateToPage(context, MainScreen());
    } else {
      Utils.navigateToPage(context, Walkthrough());
    }
  }

  @override
  void initState() {
    callFillFilterScreenSession();
    super.initState();
    callNextFlow();
  }

  void callFillFilterScreenSession() async {
    EntrancePageModel rm = EntrancePageModel();
    await rm.fillFilterScreenSession();
  }

  void callNextFlow() async {
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: EdgeInsets.only(left: 25.0, right: 25.0),
        child: Center(
            child: Image.asset('assets/Davetcim.gif',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width
            )),
      ),
    );
  }
}
