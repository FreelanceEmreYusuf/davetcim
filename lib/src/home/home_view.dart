import 'package:card_swiper/card_swiper.dart';
import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/sessions/state_management.dart';
import 'package:davetcim/widgets/slider_item.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/widgets/grid_product.dart';
import 'package:page_transition/page_transition.dart';
import '../../shared/sessions/user_state.dart';
import '../../widgets/indicator.dart';
import '../../widgets/soft_filter.dart';
import '../search/search_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  String sliderCorporationName = "";
  List<CorporationModel> corporationList =[];
  List<CorporationModel> popularCorporationModelList =[];
  IconData iconData = Icons.favorite_border_outlined;
  bool hasDataTaken = false;

  @override
  void initState() {
    StateManagement.disposeStates();
    getCorporationList();
    super.initState();
  }

  void getCorporationList() async{
    CorporateHelper corporateModel = new CorporateHelper();
    corporationList = await corporateModel.getPopularCorporate();
    popularCorporationModelList = await corporateModel.getPopularCorporateForSlider();
    setState(() {
      corporationList = corporationList;
      popularCorporationModelList = popularCorporationModelList;
      hasDataTaken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasDataTaken) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Center(
            child: Indicator(),
          ),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: <Widget>[
          SoftFilterWidget(),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onVerticalDragUpdate: (details) {
              // Aşağı kaydırma hassasiyeti
              int sensitivity = 8;
              // Aşağı kaydırma hareketi kontrolü
              if (details.delta.dy > sensitivity) {
                // Aşağı kaydırma işlemi algılandı, SearchScreen açılıyor
                Navigator.push(context, PageTransition(type: PageTransitionType.topToBottom, child: SearchScreen(),));
              }
            },
            onTap: () {
              Navigator.push(context, PageTransition(type: PageTransitionType.topToBottom, child: SearchScreen(),));
            },
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Image.asset(
                      "assets/uprow.gif",
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Davetcim Sponsorları",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.4,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Swiper(
                      duration: 1500,
                      autoplayDelay: 5000,
                      itemBuilder: (BuildContext context, int index) {
                        CorporationModel model = popularCorporationModelList[index];
                        return SliderItem(
                          corporationId: model.corporationId,
                          img: model.imageUrl,
                          isFav: UserState.isCorporationFavorite(model.corporationId),
                          name: model.corporationName,
                          rating: model.averageRating,
                          raters: model.ratingCount,
                          description: model.description,
                          maxPopulation: model.maxPopulation,
                          callerPage: null,
                        );
                      },
                      itemCount: popularCorporationModelList.length,
                      pagination: SwiperPagination(),
                      control: SwiperControl(),
                      autoplay: true,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Popüler Salonlar",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.15),
                  ),
                  itemCount: corporationList == null ? 0 : corporationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    CorporationModel item = corporationList[index];
                    return GridProduct(
                        corporationId: item.corporationId,
                        description: item.description,
                        maxPopulation: item.maxPopulation,
                        img: item.imageUrl,
                        isFav: UserState.isCorporationFavorite(item.corporationId),
                        name: item.corporationName,
                        rating: item.averageRating,
                        raters: item.ratingCount
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
