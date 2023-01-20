import 'package:card_swiper/card_swiper.dart';
import 'package:davetcim/src/comments/comments_view_model.dart';
import 'package:davetcim/src/products/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/screens/notifications.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

import '../../shared/dto/basket_user_model.dart';
import '../../shared/models/combo_generic_model.dart';
import '../../shared/models/reservation_model.dart';
import '../../shared/sessions/application_session.dart';
import '../../shared/sessions/user_basket_session.dart';
import '../../shared/utils/dialogs.dart';
import '../../shared/utils/utils.dart';
import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/carousel_calender_order_widget.dart';
import '../../widgets/carousel_calender_widget.dart';
import '../../widgets/hashtag_widget.dart';
import '../../widgets/star_and_comment.dart';
import '../fav_products/fav_products_view_model.dart';
import '../join/join_view.dart';
import '../reservation/reservation_view_model.dart';
import '../select-orders/calender/calendar_view.dart';
import '../select-orders/properties/order_view.dart';
import '../select-orders/properties/order_view_model.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
  final int corporationId;
  final String name;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;
  final int maxPopulation;
  final String description;

  ProductDetails(
      {Key key,
      @required this.corporationId,
      @required this.name,
      @required this.img,
      @required this.isFav,
      @required this.rating,
      @required this.raters,
      @required this.maxPopulation,
      @required this.description})
      : super(key: key);
}

class _ProductDetailsState extends State<ProductDetails> {
  List<String> imageList = [];
  List<String> hashtagList = [];
  List<ReservationModel> reservationList = [];
  List<Widget> commentList = [];
  bool isFavorite;

  List<ComboGenericModel> organizationTypeList = [];
  List<ComboGenericModel> sequenceOrderList = [];
  List<ComboGenericModel> invitationList = [];

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
    callGetHashtagListList();
    callGetReservationList();
    callGetProductComments();
    fillOrderViewParams();
    super.initState();
  }

  void fillOrderViewParams() async {
    OrderViewModel rm = OrderViewModel();
    organizationTypeList = await rm.getOrganizationUniqueIdentifiers(widget.corporationId);
    invitationList = await rm.getInvitationIdentifiers(widget.corporationId);
    sequenceOrderList = await rm.getSequenceOrderIdentifiers(widget.corporationId);

    setState(() {
      organizationTypeList = organizationTypeList;
      invitationList = invitationList;
      sequenceOrderList = sequenceOrderList;
    });
  }

  void callGetImageList() async {
    ProductsViewDetailModel rm = ProductsViewDetailModel();
    imageList = await rm.getImagesList(widget.corporationId);

    setState(() {
      imageList = imageList;
    });
  }

  void callGetHashtagListList() async {
    ProductsViewDetailModel rm = ProductsViewDetailModel();
    hashtagList = await rm.getHashtagList(widget.corporationId);

    setState(() {
      hashtagList = hashtagList;
    });
  }

  void callGetReservationList() async{
    ReservationViewModel rm = ReservationViewModel();
    reservationList = await rm.getReservationlist(widget.corporationId);

    setState(() {
      reservationList = reservationList;
    });
  }

  void callGetProductComments() async {
    CommentsViewModel commentsViewModel = CommentsViewModel();
    commentList = await commentsViewModel.getCorporationComments(widget.corporationId);

    setState(() {
      commentList = commentList;
    });
  }

  void editUserFavProduct() async {
    FavProductsViewModel mdl = FavProductsViewModel();
    await mdl.editFavoriteProductPage(widget.corporationId, widget.img, context, null);
    setState(() {
      isFavorite = ApplicationSession.isCorporationFavorite(widget.corporationId);
    });
  }

  List<Widget> _getListings(List _listings) {
    // <<<<< Note this change for the return type
    List<Widget> listings = [];

    for (int i = 0; i < _listings.length; i++) {
      listings.add(_listings[i]);
    }
    return listings;
  }

  static void pushToJoinPage(BuildContext context) {
    Utils.navigateToPage(context, JoinView(childPage: new Notifications()));
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    isFavorite = ApplicationSession.isCorporationFavorite(widget.corporationId);
    return Scaffold(
        appBar: AppBarMenu(pageName: widget.name, isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Stack(
          children: <Widget>[
            new Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  new Stack(
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
                          onPressed: () {
                            editUserFavProduct();
                          },
                          fillColor: Colors.white,
                          shape: CircleBorder(),
                          elevation: 4.0,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                              size: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(height: 10.0),
                  new Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                  ),
                  new HashtagWidget(hashtagList: hashtagList),
                  new Padding(
                    padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                    child: Row(
                      children: <Widget>[
                        SmoothStarRating(
                          starCount: widget.rating.round(),
                          color: Constants.ratingBG,
                          allowHalfRating: true,
                          rating: 5.0,
                          size: 10.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          widget.rating.toString() + '(' + widget.raters.toString() + ' Yorum)',
                          style: TextStyle(
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Kapasite " +  widget.maxPopulation.toString(),
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  new SizedBox(height: 20.0),
                  new Text(
                    "Hakkında",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                  ),
                  new SizedBox(height: 10.0),
                  new Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  new SizedBox(height: 20.0),
                  new Container(child: CalenderCarousel(reservationList: reservationList,corporationId: widget.corporationId, ), padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))),
                  new SizedBox(width: 10.0),
                  new Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "Yorumlar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  new SizedBox(height: 20.0),
                  new SingleChildScrollView(
                    //padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 12)),
                    child: Column(
                        children: <Widget>[
                          Container(
                            child:
                            InkWell(
                              child: StarAndComment(
                                starCount: widget.rating.round(),
                                rating: widget.rating,
                                raters: widget.raters,
                              ),
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height,
                              child:
                              ListView(
                                padding: const EdgeInsets.all(10.0),
                                children: _getListings(
                                    commentList), // <<<<< Note this change for the return type
                              )
                          ),
                        ]
                    ),
                  ),
                  SizedBox(height: 10.0),
                ]
            ),
          ],
        ),
      ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 4.0),
          height: 50.0,
          child: TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.redAccent,),
            child: Text(
              "SEPETE EKLE",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              if (ApplicationSession.userSession != null){
                BasketUserModel model = new BasketUserModel(
                    0, widget.corporationId, 0, widget.maxPopulation, 0, invitationList,
                    sequenceOrderList, reservationList, null, null, null);
                UserBasketSession.servicePoolModel = [];
                Utils.navigateToPage(context, CalendarScreen(basketModel: model));
              }
              else{
                Dialogs.showAlertMessageWithAction(
                    context,
                    "Üye girişi uyarısı",
                    "Sepetinizi oluşturabilmeniz için önce üye girişi yapmalısınız.",
                    pushToJoinPage);
              }

            },
          ),
        ),
      );

  }
}
