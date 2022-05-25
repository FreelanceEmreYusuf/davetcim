import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/src/home/home_view_model.dart';
import 'package:davetcim/src/widgets/on_error/somethingWentWrong.dart';
import 'package:davetcim/util/foods.dart';
import 'package:davetcim/widgets/slider_item.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/screens/dishes.dart';
import 'package:davetcim/widgets/grid_product.dart';
import 'package:davetcim/widgets/home_category.dart';
import 'package:davetcim/util/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    HomeViewModel mdl = new HomeViewModel();
    super.build(context);
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_)=>HomeViewModel(),
    builder: (context,child) => StreamBuilder<List<CorporationModel>>(
      stream: Provider.of<HomeViewModel>(context, listen: false).getHomeCorporationList(),
    builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
      if (asyncSnapshot.hasError) {
        return SomethingWentWrongScreen();
      }else if (asyncSnapshot.hasData) {
        List<CorporationModel> corporationList = asyncSnapshot.data.docs;
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
                    FlatButton(
                      child: Text(
                        "View More",
                        style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return DishesScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),

                SizedBox(height: 10.0),

                //Slider Here

                CarouselSlider(
                  height: MediaQuery.of(context).size.height / 2.4,
                  items: map<Widget>(
                    foods,
                        (index, i) {
                      Map food = foods[index];
                      return SliderItem(
                        img: food['img'],
                        isFav: false,
                        name: food['name'],
                        rating: 5.0,
                        raters: 23,
                      );
                    },
                  ).toList(),
                  autoPlay: true,
//                enlargeCenterPage: true,
                  viewportFraction: 1.0,
//              aspectRatio: 2.0,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                SizedBox(height: 20.0),

                Text(
                  "Food Categories",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10.0),

                Container(
                  height: 65.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories == null ? 0 : categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map cat = categories[index];
                      return HomeCategory(
                        icon: cat['icon'],
                        title: cat['name'],
                        items: cat['items'].toString(),
                        isHome: true,
                      );
                    },
                  ),
                ),

                SizedBox(height: 20.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Popular Items",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        "View More",
                        style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: () {},
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
                        (MediaQuery.of(context).size.height / 1.25),
                  ),
                  itemCount: corporationList == null ? 0 : corporationList.length,
                  itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                    CorporationModel item = corporationList[index];
                    return GridProduct(
                      img: item.imageUrl,
                      isFav: false,
                      name: item.corporationName,
                      rating: 5.0,
                      raters: 23,
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
    }
    ),

    );
  }

  @override
  bool get wantKeepAlive => true;
}
