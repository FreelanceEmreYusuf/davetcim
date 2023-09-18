import 'package:flutter/material.dart';
import 'package:davetcim/src/products/product_detail_view.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

import '../shared/helpers/corporate_helper.dart';
import '../shared/models/corporation_model.dart';
import '../shared/sessions/application_session.dart';
import '../shared/utils/utils.dart';
import '../src/fav_products/fav_products_view_model.dart';

class SliderItem extends StatelessWidget {
  final int corporationId;
  final String name;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;
  final String description;
  final int maxPopulation;
  final Widget callerPage;

  SliderItem(
      {Key key,
        @required this.corporationId,
        @required this.name,
        @required this.img,
        @required this.isFav,
        @required this.rating,
        @required this.raters,
        @required this.description,
        @required this.maxPopulation,
        @required this.callerPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3.2,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "$img",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: -10.0,
          bottom: 3.0,
          child: RawMaterialButton(
            onPressed: () {
              FavProductsViewModel mdl = FavProductsViewModel();
              mdl.editFavoriteProductPage(corporationId, img, context, callerPage);
            },
            fillColor: Colors.white,
            shape: CircleBorder(),
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 17,
              ),
            ),
          ),
        ),
      ],
    );

    if(img == null || img.isEmpty ){
      image = Icon(
        Icons.home_filled,
        size: 150.0,
        color: Colors.redAccent,
      );
    }
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          image,
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "$name",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            child: Row(
              children: <Widget>[
                SmoothStarRating(
                  starCount: 5,
                  color: Constants.ratingBG,
                  allowHalfRating: true,
                  rating: rating,
                  size: 13.0,
                ),
                Text(
                  rating.toStringAsFixed(2)+"($raters Reviews)",
                  //" $rating ($raters Reviews)",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () async {
        CorporateHelper corporationViewModel = CorporateHelper();
        CorporationModel corporationModel = await corporationViewModel.getCorporate(corporationId);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductDetails(
              corporationModel: corporationModel,);
            },
          ),
        );
      },
    );
  }
}