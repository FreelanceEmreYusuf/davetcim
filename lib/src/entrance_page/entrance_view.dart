import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/src/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/shared/utils/utils.dart';

import 'entrance_view_model.dart';

class EntrancePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  PageController _pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              //Constants.appName,
              'Davetçim',
            )),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Constants.darkAccent,
                      child: Text('Filtreleme Ekranı'),
                      onPressed: () {
                        Utils.navigateToPage(context, SearchScreen());
                      },
                    )),
                SizedBox(height: 20.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Constants.darkAccent,
                      child: Text('Anasayfa'),
                      onPressed: () {
                        Utils.navigateToPage(context, MainScreen());
                      },
                    )),
                SizedBox(height: 20.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Constants.darkAccent,
                      child: Text('Hesap Giriş'),
                      onPressed: () {
                        Utils.navigateToPage(context, JoinView());
                      },
                    )),
              ],
            )));
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    callFillFilterScreenSession();
  }

  void callFillFilterScreenSession() async {
    EntrancePageModel rm = EntrancePageModel();
    rm.fillFilterScreenSession();
  }
}
