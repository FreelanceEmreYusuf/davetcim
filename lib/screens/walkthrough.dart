import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/entrance_page/entrance_view.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:davetcim/src/join/join_view.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  List pageInfos = [
    {
      "title": "Düğün Salonları",
      "body":
          "Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus."
              " Vestibulum ac diam sit amet quam vehicula elementum sed sit amet "
              "dui. Nulla porttitor accumsan tincidunt.",
      "img": "assets/on1.png",
    },
    {
      "title": "Paket Seçimi",
      "body":
          "Cebinize uygun evlilik paketini seçebilirsiniz"
              " Düğün davet balo gibi organizasyonlarınıza özel paket seçeneklerimizle "
              "dui. Nulla porttitor accumsan tincidunt.",
      "img": "assets/on2.png",
    },
    {
      "title": "Fiyat Teklifi",
      "body":
          "Hızlı bir şekilde salon sahibinin size ulaşmasını sağlayıp"
              " Uygun fiyat teklifleri alabilirsiniz "
              "Evlilikten geçen yolda bize uğramadan geçmeyin!",
      "img": "assets/on3.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      for (int i = 0; i < pageInfos.length; i++) _buildPageModel(pageInfos[i])
    ];

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: IntroductionScreen(
            pages: pages,
            onDone: () {
              Utils.navigateToPage(context, EntrancePage());
            },
            onSkip: () {
              Utils.navigateToPage(context, EntrancePage());
            },
            showSkipButton: true,
            skip: Text("Hızlı Geç"),
            next: Text(
              "Devam",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
            done: Text(
              "Done",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPageModel(Map item) {
    return PageViewModel(
      title: item['title'],
      body: item['body'],
      image: Image.asset(
        item['img'],
        height: 185.0,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).accentColor,
        ),
        bodyTextStyle: TextStyle(fontSize: 15.0),
//        dotsDecorator: DotsDecorator(
//          activeColor: Theme.of(context).accentColor,
//          activeSize: Size.fromRadius(8),
//        ),
        pageColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
