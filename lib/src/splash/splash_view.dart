import 'dart:async';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/entrance_page/entrance_view.dart';
import 'package:davetcim/src/walkthrough/walkthrough_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:davetcim/src/walkthrough/walkthrough_view.dart';
import 'package:davetcim/shared/environments/const.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() {
    return Timer(Duration(seconds: 3), changeScreen);
  }

  changeScreen() async {
    Utils.navigateToPage(context, Walkthrough());
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    callNextFlow();
  }

  void callNextFlow() async {
    WalkthroughViewModel rm = WalkthroughViewModel();
    if (!await rm.willDemoShowed()) {
      Utils.navigateToPage(context, EntrancePage());
    } else {
      startTimeout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: EdgeInsets.only(left: 25.0, right: 25.0),
        child: Center(
            child: Image.asset('assets/2.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width
            )),
      ),
    );
  }
}
