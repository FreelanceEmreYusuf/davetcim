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
    if (!hasDataTaken) {
      return Scaffold(
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: CircularProgressIndicator())));
    }

    List pageInfos = [
      {
        "title": "${getImageByKey("weddingHall").title}",
        "body":"${getImageByKey("weddingHall").body}",
        "img": "${getImageByKey("weddingHall").imageUrl}",
      },
      {
        "title": "${getImageByKey("bundle").title}",
        "body":"${getImageByKey("bundle").body}",
        "img": "${getImageByKey("bundle").imageUrl}",
      },
      {
        "title": "${getImageByKey("priceOffer").title}",
        "body":"${getImageByKey("priceOffer").body}",
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
