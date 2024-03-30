import 'package:flutter/material.dart';
import 'package:davetcim/src/products/product_detail_view.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';
import 'package:page_transition/page_transition.dart';
import '../shared/helpers/corporate_helper.dart';
import '../shared/models/corporation_model.dart';
import '../shared/sessions/user_state.dart';
import '../src/fav_products/fav_products_view_model.dart';
import 'bounce_button.dart';

class SliderItem extends StatefulWidget {
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
  State<SliderItem> createState() => _SliderItemState();
}

class _SliderItemState extends State<SliderItem> {
  bool isFav;
  bool isPageLoad = true;

  @override
  void initState() {
    isFav = widget.isFav;
  }

  @override
  Widget build(BuildContext context) {
    if (isPageLoad) {
      isFav = widget.isFav;
    }
    Widget image = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3.2,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "${widget.img}",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: -MediaQuery.of(context).size.height / 50,
          bottom: MediaQuery.of(context).size.height / 70,
          child: BounceButton(
            child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: MediaQuery.of(context).size.width / 18,
            ),
            onTap: (){
              FavProductsViewModel mdl = FavProductsViewModel();
              mdl.editFavoriteProductPage(widget.corporationId, widget.img, context, widget.callerPage);
              if(UserState.isPresent()){
                if (isFav) {
                  setState(() {
                    isPageLoad = false;
                    isFav = false;
                  });
                } else {
                  setState(() {
                    isPageLoad = false;
                    isFav = true;
                  });
                }
              }
            },
            height: MediaQuery.of(context).size.height / 15,
            width: MediaQuery.of(context).size.width / 3,
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white70,
            ),
          ),
        ),

        Positioned(
          top: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, right: 5,),
            child: Container(
              child: SmoothStarRating(
                starCount: 5,
                color: Constants.ratingBG,
                allowHalfRating: true,
                rating: widget.rating,
                size: 25,
                borderColor: Constants.ratingBG,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.0, left: 5,),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.zero, bottomRight:  Radius.circular(20), topLeft: Radius.zero,), // Oval şekil için kenar yarıçapını belirler
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 3.0, left: 8, right: 12, top: 3),
                child: Container(
                  child: Text(
                    "${widget.name}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
            ),

          ),
        ),
      ],
    );

    if(widget.img == null || widget.img.isEmpty ){
      image = Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3.2,
            width: MediaQuery.of(context).size.width,
            child: Icon(
              Icons.home_filled,
              size: 150.0,
              color: Colors.redAccent,
            ),
          ),
          Positioned(
            right: -MediaQuery.of(context).size.height / 50,
            bottom: MediaQuery.of(context).size.height / 70,
            child: BounceButton(
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: MediaQuery.of(context).size.width / 18,
              ),
              onTap: (){
                FavProductsViewModel mdl = FavProductsViewModel();
                mdl.editFavoriteProductPage(widget.corporationId, widget.img, context, widget.callerPage);
                if(UserState.isPresent()){
                  if (isFav) {
                    setState(() {
                      isPageLoad = false;
                      isFav = false;
                    });
                  } else {
                    setState(() {
                      isPageLoad = false;
                      isFav = true;
                    });
                  }
                }
              },
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 3,
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.black12, // Temaya göre metin rengi
              ),
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, right: 5,),
              child: Container(
                child: SmoothStarRating(
                  starCount: 5,
                  color: Constants.ratingBG,
                  allowHalfRating: true,
                  rating: widget.rating,
                  size: 25,
                  borderColor: Constants.ratingBG,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0, left: 5,),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.zero, bottomRight:  Radius.circular(20), topLeft: Radius.zero,), // Oval şekil için kenar yarıçapını belirler
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 3.0, left: 8, right: 12, top: 3),
                  child: Container(
                    child: Text(
                      "${widget.name}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
              ),

            ),
          ),
        ],
      );

    }
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          image,
        ],
      ),
      onTap: () async {
        CorporateHelper corporationViewModel = CorporateHelper();
        CorporationModel corporationModel = await corporationViewModel.getCorporate(widget.corporationId);
        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,  child: ProductDetails(
          corporationModel: corporationModel,)));
      },
    );
  }
}