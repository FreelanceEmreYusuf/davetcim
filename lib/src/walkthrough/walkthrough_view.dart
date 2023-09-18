import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/entrance_page/entrance_view.dart';
import 'package:davetcim/src/walkthrough/walkthrough_view_model.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../shared/models/application_image_model.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  List<ApplicationImageModel> applicationImageList = [];
  bool hasDataTaken = false;

  @override
  void initState() {
    getImageList();
    super.initState();
  }

  void getImageList() async {
    WalkthroughViewModel walkthroughViewModel = WalkthroughViewModel();
    List<ApplicationImageModel> applicationImageDbList = await walkthroughViewModel.getApplicationImageList();
    setState(() {
      applicationImageList = applicationImageDbList;
      hasDataTaken = true;
    });
  }

  ApplicationImageModel getImageByKey(String key) {
    for(int i = 0; i < applicationImageList.length; i++) {
      if (applicationImageList[i].key == key) {
        return applicationImageList[i];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    List pageInfos = [
      {
        "title": "Düğün Salonları",
        "body":
        "En güzel gecene ev sahipliği yapacak olan düğün salonuna karar vermeden önce,"
            "  düğün salonu galerilerine göz at,  "
            "en güzel düğün salonu dekorasyonu örneklerini incele!.",
        "img": "${getImageByKey("weddingHall").imageUrl}",
      },
      {
        "title": "Paket Seçimi",
        "body": "Cebinize uygun evlilik paketini seçebilirsiniz"
            " Düğün davet balo gibi organizasyonlarınıza özel paket seçeneklerimizle "
            "dui. Nulla porttitor accumsan tincidunt.",
        "img": "${getImageByKey("bundle").imageUrl}",
      },
      {
        "title": "Fiyat Teklifi",
        "body": "Hızlı bir şekilde salon sahibinin size ulaşmasını sağlayıp"
            " Uygun fiyat teklifleri alabilirsiniz "
            "Evlilikten geçen yolda bize uğramadan geçmeyin!",
        "img": "${getImageByKey("priceOffer").imageUrl}",
      },
    ];

    WalkthroughViewModel model = WalkthroughViewModel();
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
              model.createBypassInfoData();
              Utils.navigateToPage(context, EntrancePage());
            },
            showSkipButton: true,
            skip: Text("Birdaha Gösterme"),
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
      image: Image.network(
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
