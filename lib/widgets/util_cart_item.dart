import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/src/products/product_detail_view.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

class UtilCartItem extends StatelessWidget {
  final String title;
  final String img;
  final String subtitle;
  final String tooltip;
  final IconData icon;
  final Widget screen;

  UtilCartItem({
    Key key,
    @required this.title,
    @required this.img,
    @required this.subtitle,
    @required this.tooltip,
    @required this.screen,
    @required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            Utils.navigateToPage(context, screen);
          },
          child: Card(
              elevation: 4.0,
              child: Stack(children: <Widget>[
                Image.network(
                  img,
                  fit: BoxFit.fill,
                ),
                Center(
                  child: ListTile(
                    tileColor: Colors.white70,
                    leading: IconButton(
                      tooltip: tooltip,
                      iconSize: MediaQuery.of(context).size.width / 8,
                      icon: Icon(
                        icon,
                        color: Colors.redAccent,
                      ),
                    ),
                    title: Text(
                      title,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
