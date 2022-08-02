import 'package:card_swiper/card_swiper.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/src/home/home_view_model.dart';
import 'package:davetcim/widgets/slider_item.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/widgets/grid_product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

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

  int _current = 0;
  bool isFav = false;
  String sliderCorporationName = "";


  @override
  Widget build(BuildContext context) {
    HomeViewModel mdl = new HomeViewModel();
    super.build(context);
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      builder: (context, child) => StreamBuilder<List<CorporationModel>>(
          stream: Provider.of<HomeViewModel>(context, listen: false)
              .getHomeCorporationList(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            mdl.getUserName(),
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.0),
                      SizedBox(height: 10.0),
                      //Slider Here

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
                                  CorporationModel model = corporationList[index];
                                  return SliderItem(
                                    corporationId: model.corporationId,
                                    img: model.imageUrl,
                                    isFav: false,
                                    name: model.corporationName,
                                    rating: model.averageRating,
                                    raters: model.ratingCount,
                                    description: model.description,
                                    maxPopulation: model.maxPopulation,
                                  );
                                  //Image.network(corporationList[index].imageUrl,fit: BoxFit.fill,);
                                },
                                itemCount: corporationList.length,
                                pagination: SwiperPagination(),
                                control: SwiperControl(),
                                autoplay: false,
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
                            "Öne Çıkanlar",
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
                            isFav: false,
                            name: item.corporationName,
                            rating: item.averageRating,
                            raters: item.ratingCount,
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
