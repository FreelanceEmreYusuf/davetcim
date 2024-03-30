import 'package:davetcim/shared/sessions/user_state.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/widgets/grid_product.dart';

import '../../shared/models/corporation_model.dart';
import 'fav_products_view_model.dart';
import 'favorite_screen_with_appbar.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with AutomaticKeepAliveClientMixin<FavoriteScreen> {

  List<CorporationModel> corpModelList = [];

  void callFillFavoriteCorporations() async {
    FavProductsViewModel rm = FavProductsViewModel();
    corpModelList = await rm.getFavProductDetailedList();

    setState(() {
      corpModelList = corpModelList;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    callFillFavoriteCorporations();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              "Favori Mekanlarım",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
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
              itemCount: corpModelList == null ? 0 : corpModelList.length,
              itemBuilder: (BuildContext context, int index) {
                  CorporationModel corp = corpModelList[index];
                return GridProduct(
                  img: corp.imageUrl,
                  isFav:UserState.isCorporationFavorite(corp.corporationId),
                  name: corp.corporationName,
                  rating: corp.averageRating,
                  raters: corp.ratingCount,
                  maxPopulation: corp.maxPopulation,
                  corporationId: corp.corporationId,
                  description: corp.description,
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
