import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/src/search/search_view.dart';
import 'package:davetcim/widgets/animated_fab.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:davetcim/widgets/fancy_fab.dart';
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
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width / 15,
                horizontal: MediaQuery.of(context).size.width / 20),
            child: ListView(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      elevation: 4.0,
                      child: ListTile(
                        tileColor: Constants.darkAccent,
                        leading: IconButton(
                          tooltip: "Organizasyon için en uygun mekanı bul",
                          iconSize: MediaQuery.of(context).size.width / 8,
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          "Mekan Filtreleme Robotu",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          "Düğün, Kına, Doğum Günü ve daha birçok organizasyon için kriterlerinize uygun mekanı biz sizin için bulalım.",
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        onTap: () {
                          Utils.navigateToPage(context, SearchScreen());
                        },
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 20.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      elevation: 4.0,
                      child: ListTile(
                        tileColor: Constants.darkAccent,
                        leading: IconButton(
                          tooltip: "Ana Sayfaya git",
                          iconSize: MediaQuery.of(context).size.width / 8,
                          icon: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          "Ana Sayfa",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          "Uygulamamızın ana sayfasına gider, burada öne çıkan mekanları görebilir avantajlı teklifler alabilirsiniz.",
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        onTap: () {
                          Utils.navigateToPage(context, MainScreen());
                        },
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 20.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      elevation: 4.0,
                      child: ListTile(
                        tileColor: Constants.darkAccent,
                        leading: IconButton(
                          tooltip: "Üye Grişi",
                          iconSize: MediaQuery.of(context).size.width / 8,
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          "Üye Girişi / Yeni Üyelik",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          "Avantajlı tekliflerden yararlanabilmek, favorilerinizi seçebilmek ve sepetinizi doldurabilmek için üye girişi yapabilirsiniz. Ayrıca üye değilseniz yeni üyelik oluşturabilirsiniz",
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        onTap: () {
                          Utils.navigateToPage(context, JoinView());
                        },
                      ),
                    ),
                  ),
                ),
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
