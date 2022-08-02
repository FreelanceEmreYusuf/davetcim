import 'package:flutter/material.dart';
import 'package:davetcim/screens/notifications.dart';
import 'package:davetcim/util/categories.dart';
import 'package:davetcim/util/foods.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:davetcim/widgets/grid_product.dart';
import 'package:davetcim/widgets/home_category.dart';

import '../widgets/app_bar/app_bar_view.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String catie = "Drinks";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(pageName: "Categories", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
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
                    isHome: false,
                    tap: () {
                      setState(() {
                        catie = "${cat['name']}";
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "$catie",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            Divider(),
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
              itemCount: foods == null ? 0 : foods.length,
              itemBuilder: (BuildContext context, int index) {
                Map food = foods[index];
                return GridProduct(
                  img: food['img'],
                  isFav: false,
                  name: food['name'],
                  rating: 5.0,
                  raters: 23,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
