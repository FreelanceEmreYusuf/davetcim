import 'package:card_swiper/card_swiper.dart';
import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/src/home/home_view_model.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/widgets/bounce_button.dart';
import 'package:davetcim/widgets/slider_item.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/widgets/grid_product.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../shared/environments/const.dart';
import '../../shared/sessions/user_basket_session.dart';
import '../../widgets/on_error/somethingWentWrong.dart';

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
  List<int> orderedCorporationList =[];
  List<CorporationModel> popularCorporationModelList =[];
  IconData iconData = Icons.favorite_border_outlined;

  @override
  void initState() {
    UserBasketSession.servicePoolModel = [];
    getOrderedCorporationList();
    getHomeSliderCorporationList();
    super.initState();
  }

  void getOrderedCorporationList() async{
    HomeViewModel homeViewModel = new HomeViewModel();
    orderedCorporationList = await homeViewModel.getMountLogs(50);
    setState(() {
      orderedCorporationList = orderedCorporationList;
    });
  }

  void getHomeSliderCorporationList() async{
    CorporateHelper corporateModel = new CorporateHelper();
    popularCorporationModelList = await corporateModel.getPopularCorporate();
    setState(() {
      popularCorporationModelList = popularCorporationModelList;
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel mdl = new HomeViewModel();
    super.build(context);
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      builder: (context, child) => StreamBuilder<List<CorporationModel>>(
          stream: Provider.of<HomeViewModel>(context, listen: false)
              .getHomeCorporationList(orderedCorporationList),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return SomethingWentWrongScreen();
            } else if (asyncSnapshot.hasData) {
              List<CorporationModel> corporationList = asyncSnapshot.data;
              return Scaffold(
                body: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                  child: ListView(
                    children: <Widget>[
                      if(ApplicationSession.userSession != null)
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Hoşgeldin ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              BounceButton(
                                child: Text(
                                  "@"+mdl.getUserName(),
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.lightGreen
                                  ),
                                ),
                                onTap: (){

                                },
                                duration: Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                    color: Provider.of<AppProvider>(context).theme ==
                                        Constants.lightTheme
                                        ? Colors.white
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 10,),
                      Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 2.4,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              //       !loading ? HomeCarousel(homeManager) : Center(child:ProgressIndicator())
                              child: Swiper(
                                itemBuilder: (BuildContext context,int index){
                                  CorporationModel model = popularCorporationModelList[index];
                                  return SliderItem(
                                    corporationId: model.corporationId,
                                    img: model.imageUrl,
                                    isFav: ApplicationSession.isCorporationFavorite(model.corporationId),
                                    name: model.corporationName,
                                    rating: model.averageRating,
                                    raters: model.ratingCount,
                                    description: model.description,
                                    maxPopulation: model.maxPopulation,
                                    callerPage: null,
                                  );
                                  //Image.network(corporationList[index].imageUrl,fit: BoxFit.fill,);
                                },
                                itemCount: popularCorporationModelList.length,
                                pagination: SwiperPagination(),
                                control: SwiperControl(),
                                autoplay: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Son Zamanlarda Populer",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.15),
                        ),
                        itemCount: corporationList == null
                            ? 0
                            : corporationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          CorporationModel item = corporationList[index];
                          return GridProduct(
                            corporationId: item.corporationId,
                            description: item.description,
                            maxPopulation: item.maxPopulation,
                            img: item.imageUrl,
                            isFav: ApplicationSession.isCorporationFavorite(item.corporationId),
                            name: item.corporationName,
                            rating: item.averageRating,
                            raters: item.ratingCount,
                            callerPage: MainScreen(),
                          );
                        },
                      ),

                      SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
