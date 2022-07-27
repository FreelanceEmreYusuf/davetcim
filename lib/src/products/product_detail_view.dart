import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:davetcim/src/products/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/screens/notifications.dart';
import 'package:davetcim/util/comments.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

import '../../shared/models/reservation_model.dart';
import '../../widgets/carousel_calender_widget.dart';
import '../../widgets/slider_image_item.dart';
import '../../widgets/slider_item.dart';
import '../reservation/reservation_view_model.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
  final int corporationId;
  final String name;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;
  final String description;

  ProductDetails(
      {Key key,
      @required this.corporationId,
      @required this.name,
      @required this.img,
      @required this.isFav,
      @required this.rating,
      @required this.raters,
      @required this.description})
      : super(key: key);
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFav = false;
  List<String> imageList = [];
  List<ReservationModel> reservationList = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    callGetImageList();
    callGetReservationList();
    super.initState();
  }

  void callGetImageList() async {
    ProductsViewDetailModel rm = ProductsViewDetailModel();
    imageList = await rm.getImagesList(widget.corporationId);

    setState(() {
      imageList = imageList;
    });
  }

  void callGetReservationList() async{
    ReservationViewModel rm = ReservationViewModel();
    reservationList = await rm.getReservationlist(widget.corporationId);

    setState(() {
      reservationList = reservationList;
    });
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
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
            widget.name,
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
              SizedBox(height: 10.0),
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.2,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      //       !loading ? HomeCarousel(homeManager) : Center(child:ProgressIndicator())
                      child: Swiper(
                        itemBuilder: (BuildContext context,int index){
                          return Image.network(imageList[index],fit: BoxFit.fill,);
                        },
                        itemCount: imageList.length,
                        pagination: SwiperPagination(),
                        control: SwiperControl(),
                        autoplay: true,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -10.0,
                    bottom: 3.0,
                    child: RawMaterialButton(
                      onPressed: () {},
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
              ),
              SizedBox(height: 10.0),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                child: Row(
                  children: <Widget>[
                    SmoothStarRating(
                      starCount: 5,
                      color: Constants.ratingBG,
                      allowHalfRating: true,
                      rating: 5.0,
                      size: 10.0,
                    ),
                    SizedBox(width: 10.0),


                    Text(
                      "5.0 (23 Yorum)",
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Kapasite 500",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      r"$90",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),





              Text(
                "Hakkında",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
              ),
              SizedBox(height: 10.0),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 20.0),
              CalenderCarousel(reservationList: reservationList,),
              SizedBox(width: 10.0),
              Text(
                "Yorumlar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
              ),
              SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                itemCount: comments == null ? 0 : comments.length,
                itemBuilder: (BuildContext context, int index) {
                  Map comment = comments[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage(
                        "${comment['img']}",
                      ),
                    ),
                    title: Text("${comment['name']}"),
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SmoothStarRating(
                              starCount: 5,
                              color: Constants.ratingBG,
                              allowHalfRating: true,
                              rating: 5.0,
                              size: 12.0,
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              "February 14, 2020",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7.0),
                        Text(
                          "${comment["comment"]}",
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50.0,
          child: RaisedButton(
            child: Text(
              "SEPETE EKLE",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ),
      );

  }
}
