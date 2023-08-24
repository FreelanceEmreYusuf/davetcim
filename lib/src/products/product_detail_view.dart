import 'package:card_swiper/card_swiper.dart';
import 'package:davetcim/src/comments/comments_view_model.dart';
import 'package:davetcim/src/products/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/screens/notifications.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

import '../../shared/dto/basket_user_dto.dart';
import '../../shared/models/combo_generic_model.dart';
import '../../shared/models/corporation_model.dart';
import '../../shared/models/reservation_model.dart';
import '../../shared/sessions/application_session.dart';
import '../../shared/sessions/user_basket_session.dart';
import '../../shared/utils/dialogs.dart';
import '../../shared/utils/utils.dart';
import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/carousel_calender_widget.dart';
import '../../widgets/hashtag_widget.dart';
import '../../widgets/star_and_comment.dart';
import '../comments/comments_view.dart';
import '../fav_products/fav_products_view_model.dart';
import '../join/join_view.dart';
import '../reservation/reservation_view_model.dart';
import '../select-orders/calender/calendar_view.dart';
import '../select-orders/properties/order_view_model.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
  final CorporationModel corporationModel;

  ProductDetails(
      {Key key,
      @required this.corporationModel})
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
  bool calenderVisibility;
  String buttonText;
  IconData icon = Icons.keyboard_arrow_down;
  String districtName = "";
  String regionName = "";

  @override
  void initState() {
    getDistrictRegionName(int.parse(widget.corporationModel.district), int.parse(widget.corporationModel.region));
    calenderVisibility = false;
    buttonText = "Takvimi Göster";
    callGetImageList();
    callGetHashtagListList();
    callGetReservationList();
    callGetProductComments();
    fillOrderViewParams();
    super.initState();
  }

  Future<void> getDistrictRegionName(int districtId, int regionId) async{
    ProductsViewDetailModel productsViewDetailModel = ProductsViewDetailModel();
    districtName = await productsViewDetailModel.getDistrict(districtId);
    regionName = await productsViewDetailModel.getRegion(regionId);

    districtName = districtName.substring(1);
    regionName = regionName.substring(1);
  }



  void fillOrderViewParams() async {
    OrderViewModel rm = OrderViewModel();
    organizationTypeList = await rm.getOrganizationUniqueIdentifiers(widget.corporationModel.corporationId);
    invitationList = await rm.getInvitationIdentifiers(widget.corporationModel.corporationId);
    sequenceOrderList = await rm.getSequenceOrderIdentifiers(widget.corporationModel.corporationId);

    setState(() {
      organizationTypeList = organizationTypeList;
      invitationList = invitationList;
      sequenceOrderList = sequenceOrderList;
    });
  }

  void callGetImageList() async {
    ProductsViewDetailModel rm = ProductsViewDetailModel();
    imageList = await rm.getImagesList(widget.corporationModel.corporationId);

    setState(() {
      imageList = imageList;
    });
  }

  void callGetHashtagListList() async {
    ProductsViewDetailModel rm = ProductsViewDetailModel();
    hashtagList = await rm.getHashtagList(widget.corporationModel.corporationId);

    setState(() {
      hashtagList = hashtagList;
    });
  }

  void callGetReservationList() async{
    ReservationViewModel rm = ReservationViewModel();
    reservationList = await rm.getReservationlist(widget.corporationModel.corporationId);

    setState(() {
      reservationList = reservationList;
    });
  }

  void callGetProductComments() async {
    CommentsViewModel commentsViewModel = CommentsViewModel();
    commentList = await commentsViewModel.getCorporationComments(widget.corporationModel.corporationId);

    setState(() {
      commentList = commentList;
    });
  }

  void editUserFavProduct() async {
    FavProductsViewModel mdl = FavProductsViewModel();
    await mdl.editFavoriteProductPage(widget.corporationModel.corporationId, widget.corporationModel.imageUrl, context, null);
    setState(() {
      isFavorite = ApplicationSession.isCorporationFavorite(widget.corporationModel.corporationId);
    });
  }

  static void pushToJoinPage(BuildContext context) {
    Utils.navigateToPage(context, JoinView(childPage: new Notifications()));
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    isFavorite = ApplicationSession.isCorporationFavorite(widget.corporationModel.corporationId);
    return Scaffold(
        appBar: AppBarMenu(pageName: widget.corporationModel.corporationName, isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Stack(
          children: <Widget>[
            Column(
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
                  SizedBox(height:MediaQuery.of(context).size.height/50,),
                  Text(
                    widget.corporationModel.corporationName,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                  ),
                  HashtagWidget(hashtagList: hashtagList),
                  SizedBox(height: MediaQuery.of(context).size.height/50,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: [
                                SmoothStarRating(
                                  starCount: widget.corporationModel.averageRating.round(),
                                  color: Constants.ratingBG,
                                  allowHalfRating: true,
                                  rating: 5.0,
                                  size: MediaQuery.of(context).size.height/25,
                                ),
                                Text(
                                  widget.corporationModel.averageRating.toString() + ' Puan',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.orange
                                  ),
                                ),
                                Text(
                                   widget.corporationModel.ratingCount.toString() + ' Yorum',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.redAccent
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Maximum Kapasite",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.deepOrange
                                  ),
                                ),
                                Text(
                                  widget.corporationModel.maxPopulation.toString(),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.deepOrangeAccent
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/50,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.redAccent,
                      color: Colors.redAccent,
                      child: Container(
                        margin: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: [
                                Icon(Icons.phone, size: 25, color: Colors.white),
                                Text(
                                  'Telefon',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  ),
                                ),
                                Text(
                                  widget.corporationModel.telephoneNo,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.mail, size: 25, color: Colors.white,),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  ),
                                ),
                                Text(
                                  widget.corporationModel.email.toString(),
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/30),
                  Card(
                    elevation: 10,
                    shadowColor: Colors.redAccent,
                    child: Container(
                      margin: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            "Adres",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.redAccent
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height/50,),
                          Text(
                            widget.corporationModel.address,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height/50,),
                          Text(
                            districtName+"/"+regionName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/30),
                  Card(
                    elevation: 10,
                    shadowColor: Colors.redAccent,
                    child: Container(
                      margin: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            "Hakkında",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.redAccent
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height/50,),
                          Text(
                            widget.corporationModel.description,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  ListView(
                      physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children : <Widget>[
                      Card(
                        elevation: 15,
                        shadowColor: Colors.redAccent,
                        color: Colors.red,
                        child: MaterialButton(
                          textColor: Colors.white,
                          color: Colors.redAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(buttonText, style: TextStyle(fontSize: 18),),
                              Icon(icon, size: 22,),
                            ],
                          ),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            setState(() {
                              calenderVisibility = !calenderVisibility;
                              if(calenderVisibility){
                                buttonText = "Takvimi Gizle";
                                icon = Icons.keyboard_arrow_up;
                              }
                              else
                                {
                                  buttonText = "Takvimi Göster";
                                  icon = Icons.keyboard_arrow_down;
                                }
                            });
                          },
                        ),
                      ),
                      Visibility(
                          visible: calenderVisibility,
                          child: Container(
                              child: CalenderCarousel(reservationList: reservationList,corporationId: widget.corporationModel.corporationId, ),
                              padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
                          )),
                    ]
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/30),
                  Card(
                    elevation: 20,
                    shadowColor: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        //padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 12)),
                        child: Column(
                            children: <Widget>[
                              Text(
                                "Yorumlar",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                                maxLines: 2,
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height/30),
                              Container(
                                child:
                                InkWell(
                                  child: StarAndComment(
                                    starCount: widget.corporationModel.averageRating.round(),
                                    rating: double.parse(widget.corporationModel.averageRating.toStringAsFixed(2)),
                                    raters: widget.corporationModel.ratingCount,
                                  ),
                                ),
                              ),
                              Container(
                                  height: MediaQuery.of(context).size.height /1.5 ,
                                  child:
                                  ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(10.0),
                                    children: commentList, // <<<<< Note this change for the return type
                                  )
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height/30),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children : <Widget>[
                                      MaterialButton(
                                        textColor: Colors.white,
                                        color: Colors.redAccent,
                                        child: Text("Tüm Yorumları Göster"),
                                        minWidth: MediaQuery.of(context).size.width,
                                        onPressed: () async {
                                          Utils.navigateToPage(context, CommentsView(commentList: commentList));
                                        },
                                      ),
                                    ]
                                ),
                              ),
                            ]
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/50),
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
              "REZERVASYON OLUŞTUR",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              if (ApplicationSession.userSession != null){
                BasketUserDto model = new BasketUserDto(
                    0, widget.corporationModel.corporationId, 0, widget.corporationModel.maxPopulation, 0, invitationList,
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
