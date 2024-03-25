import 'package:card_swiper/card_swiper.dart';
import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/sessions/reservation_edit_state.dart';
import 'package:davetcim/src/home/home_view_model.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/widgets/bounce_button.dart';
import 'package:davetcim/widgets/slider_item.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/widgets/grid_product.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../shared/environments/const.dart';
import '../../shared/sessions/corporation_registration_state.dart';
import '../../shared/sessions/product_filterer_state.dart';
import '../../shared/sessions/user_basket_state.dart';
import '../../shared/sessions/user_state.dart';
import '../../widgets/on_error/somethingWentWrong.dart';
import '../../widgets/soft_filter.dart';

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
    UserBasketState.setAsNull();
    CorporationRegistrationState.setAsNull();
    ReservationEditState.setAsNull();
    ProductFiltererState.setAsNull();
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
                body: ListView(
                  children: <Widget>[
                    SoftFilterWidget(),
                    if(UserState.isPresent())
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            SizedBox(width: 10),
                            BounceButton(
                              onTap: () {},
                              child: Text(
                                "@${mdl.getUserName()}",
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.lightGreen,
                                ),
                              ),
                              duration: Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: Provider.of<AppProvider>(context).theme == Constants.lightTheme
                                    ? Colors.transparent
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Son Zamanlarda Popüler",
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
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
