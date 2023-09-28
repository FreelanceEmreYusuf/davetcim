import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/src/search/search_view.dart';
import 'package:davetcim/widgets/animated_fab.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:davetcim/widgets/fancy_fab.dart';
import 'package:davetcim/widgets/util_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/shared/utils/utils.dart';

import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/app_bar/app_bar_without_previous_icon_view.dart';
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
        appBar: AppBarMenuWithOutPreviousPageIcon(pageName: "Davetcim", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
        body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width / 15,
                horizontal: MediaQuery.of(context).size.width / 20),
            child: ListView(
              children: <Widget>[
                UtilCartItem(
                  icon: Icons.search,
                  tooltip: "Organizasyon için en uygun mekanı bul",
                  img:
                      'https://i.pinimg.com/564x/6c/b1/69/6cb16913d2e46c32ef46989145f5900d.jpg',
                  title: "Davet Filtreleme Robotu",
                  subtitle:"",
                      //"Düğün, Kına, Doğum Günü ve daha birçok organizasyon için kriterlerinize uygun mekanı biz sizin için bulalım.",
                  screen: SearchScreen(),
                ),
                UtilCartItem(
                  icon: Icons.home,
                  tooltip: "Ana Sayfaya git",
                  img:
                      'https://focuspg.com.au/wp-content/uploads/2019/08/home-loan-grid-img-1-new.jpg',
                  title: "Ana Sayfa",
                  subtitle:"",
                      //"Uygulamamızın ana sayfasına gider, burada öne çıkan mekanları görebilir avantajlı teklifler alabilirsiniz.",
                  screen: MainScreen(),
                ),
                UtilCartItem(
                  icon: Icons.person,
                  tooltip:
                      "Üye Grişi yapmak veya yeni üyelik oluşturmak için dokunun",
                  img:
                      'https://carta.v-card.es/assets/images/user/login.png',
                  title: "Üye Girişi / Yeni Üyelik",
                  subtitle:"",
                      //"Avantajlı tekliflerden yararlanabilmek, favorilerinizi seçebilmek ve sepetinizi doldurabilmek için üye girişi yapabilirsiniz. Ayrıca üye değilseniz yeni üyelik oluşturabilirsiniz",
                  screen: JoinView(),
                ),
              ],
            )));
  }

  @override
  void initState() {
    callFillFilterScreenSession();
    super.initState();
    _pageController = PageController();
  }

  void callFillFilterScreenSession() async {
    EntrancePageModel rm = EntrancePageModel();
    await rm.fillFilterScreenSession();
  }
}
