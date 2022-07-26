import 'package:flutter/material.dart';
import 'package:davetcim/src/products/product_detail_view.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

class SliderImageItem extends StatelessWidget {
  final String img;

  SliderImageItem(
      {Key key,
      @required this.img,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
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
            ],
          ),
        ],
      ),
    );

  }
}
