import 'package:davetcim/shared/dto/product_filterer_dto.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/src/products/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/widgets/grid_product.dart';

import '../../shared/sessions/user_state.dart';
import '../../widgets/app_bar/app_bar_view.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
  final List<CorporationModel> corporationInputList;
  const ProductsScreen(this.corporationInputList);
}

class _ProductsScreenState extends State<ProductsScreen>  {

  List<CorporationModel> corporationList = [];
  bool hasDataTaken = false;

  @override
  void initState() {
    getCorporationList();
    super.initState();
  }

  Future getCorporationList() async {
    if (widget.corporationInputList != null) {
      corporationList = widget.corporationInputList;
    } else {
      ProductsViewModel mdl = new ProductsViewModel();
      corporationList = await mdl.getCorporationList();
    }

    setState(() {
      corporationList = corporationList;
      hasDataTaken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Salonlar", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: CircularProgressIndicator())));
    }

      return Scaffold(
        appBar: AppBarMenu(pageName: "Salonlar", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body: Padding(
          padding: EdgeInsets.all(10.0),
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
                    isFav: UserState.isCorporationFavorite(item.corporationId),
                    name: item.corporationName,
                    rating: item.averageRating,
                    raters: item.ratingCount,
                    description: item.description,
                    corporationId: item.corporationId,
                    maxPopulation: item.maxPopulation
                  );
                },
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      );
  }
}
