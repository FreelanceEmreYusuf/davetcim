import 'package:davetcim/shared/dto/product_filterer.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/src/products/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/screens/notifications.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:davetcim/widgets/grid_product.dart';

import '../../screens/notifications.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();

  final ProductFilterer filter;
  const ProductsScreen(this.filter);
}

class _ProductsScreenState extends State<ProductsScreen>  {

  List<CorporationModel> corporationList = [];

  Future getCorporationList() async {
    ProductsViewModel mdl = new ProductsViewModel();
    corporationList = await mdl.getCorporationList(widget.filter);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              "Salonlar",
            ),
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: IconBadge(
                  icon: Icons.notifications,
                  size: 22.0,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Notifications();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: ListView(
              children: <Widget>[
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
                      img: item.imageUrl,
                      isFav: false,
                      name: item.corporationName,
                      rating: 5.0,
                      raters: 23,
                    );
                  },
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        );
      },
      future: getCorporationList(),
    );
  }
}
