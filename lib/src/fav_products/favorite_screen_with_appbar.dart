import 'package:flutter/material.dart';
import 'package:davetcim/widgets/grid_product.dart';

import '../../shared/models/corporation_model.dart';
import '../../shared/sessions/reservation_edit_state.dart';
import '../../shared/sessions/user_state.dart';
import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/app_bar/app_bar_view_with_back_home_page.dart';
import '../../widgets/app_bar/app_bar_without_previous_icon_view.dart';
import '../main/main_screen_view.dart';
import 'fav_products_view_model.dart';

class FavoriteScreenWithAppBar extends StatefulWidget {
  @override
  _FavoriteScreenWithAppBarState createState() => _FavoriteScreenWithAppBarState();
}

class _FavoriteScreenWithAppBarState extends State<FavoriteScreenWithAppBar>
    with AutomaticKeepAliveClientMixin<FavoriteScreenWithAppBar> {

  List<CorporationModel> corpModelList = [];

  @override
  void initState() {
    super.initState();
    callFillFavoriteCorporations();
  }

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
    return WillPopScope(
      onWillPop: () async {
        // Geri tuşuna basıldığında MainScreen'a git
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
              (Route<dynamic> route) => false,
        );
        return true; // Geri tuşunun işleme devam etmesini sağlar
      },
      child: Scaffold(
        appBar: AppBarMenuBackToHomePage(pageName: "Favori Mekanlarım", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
                    isFav: UserState.isCorporationFavorite(corp.corporationId),
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
