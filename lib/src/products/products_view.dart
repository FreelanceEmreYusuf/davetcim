import 'package:davetcim/shared/dto/product_filterer.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/src/products/products_view_model.dart';
import 'package:davetcim/src/widgets/on_error/somethingWentWrong.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/screens/notifications.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:davetcim/widgets/grid_product.dart';
import 'package:provider/provider.dart';

import '../../screens/notifications.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();

  final ProductFilterer filter;
  const ProductsScreen(this.filter);
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductsViewModel>(
      create: (_) => ProductsViewModel(),
      builder: (context, child) => StreamBuilder<List<CorporationModel>>(
          stream: Provider.of<ProductsViewModel>(context, listen: false)
              .getCorporationList(widget.filter),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return SomethingWentWrongScreen();
            } else if (asyncSnapshot.hasData) {
              List<CorporationModel> corporationList = asyncSnapshot.data;
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
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
