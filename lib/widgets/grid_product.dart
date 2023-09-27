import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/src/products/product_detail_view.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';
import '../shared/sessions/application_session.dart';
import '../shared/utils/utils.dart';
import '../src/fav_products/fav_products_view_model.dart';
import 'bounce_button.dart';

class GridProduct extends StatefulWidget {
  final String name;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;
  final String description;
  final int corporationId;
  final int maxPopulation;
  final Widget callerPage;

  GridProduct(
      {Key key,
      @required this.name,
      @required this.img,
      @required this.isFav,
      @required this.rating,
      @required this.raters,
      @required this.description,
      @required this.corporationId,
      @required this.maxPopulation,
      @required this.callerPage,
      })
      : super(key: key);

  @override
  State<GridProduct> createState() => _GridProductState();
}

class _GridProductState extends State<GridProduct> {

  bool isFavorite;

  void editUserFavProduct() async {
    FavProductsViewModel mdl = FavProductsViewModel();
    await mdl.editFavoriteProductPage(widget.corporationId, widget.img, context, null);
    setState(() {
      isFavorite = ApplicationSession.isCorporationFavorite(widget.corporationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget img = Image.network(
      "${widget.img}",
      fit: BoxFit.cover,
    );
    isFavorite =  ApplicationSession.isCorporationFavorite(widget.corporationId);
    if(widget.img == null ||widget.img.isEmpty ){
      img = Icon(
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
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.6,
                width: MediaQuery.of(context).size.width / 2.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: img,
                ),
              ),
              Positioned(
                right: -MediaQuery.of(context).size.height / 60,
                bottom: MediaQuery.of(context).size.height / 100,
                child: BounceButton(
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: MediaQuery.of(context).size.width / 18,
                  ),
                  onTap: (){
                    editUserFavProduct();
                  },
                  height: MediaQuery.of(context).size.height / 17,
                  width: MediaQuery.of(context).size.width / 4.5,
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "${widget.name}",
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
                  rating: widget.rating,
                  size: 13.0,
                ),
                Text(
                  " ${widget.rating.toStringAsFixed(2)} (${widget.raters} Reviews)",
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () async {
        CorporateHelper corporationViewModel = CorporateHelper();
        CorporationModel corporationModel = await corporationViewModel.getCorporate(widget.corporationId);
        Utils.navigateToPage(context, ProductDetails(corporationModel: corporationModel,));
      },
    );
  }
}
