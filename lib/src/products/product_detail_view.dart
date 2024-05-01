import 'package:card_swiper/card_swiper.dart';
import 'package:davetcim/shared/helpers/general_helper.dart';
import 'package:davetcim/src/comments/comments_view_model.dart';
import 'package:davetcim/src/products/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/enums/corporation_event_log_enum.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import '../../shared/models/combo_generic_model.dart';
import '../../shared/models/corporation_event_log_model.dart';
import '../../shared/models/corporation_model.dart';
import '../../shared/models/reservation_model.dart';
import '../../shared/sessions/user_basket_state.dart';
import '../../shared/sessions/user_state.dart';
import '../../shared/utils/dialogs.dart';
import '../../shared/utils/utils.dart';
import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/bounce_button.dart';
import '../../widgets/carousel_calender_widget.dart';
import '../../widgets/hashtag_widget.dart';
import '../../widgets/indicator.dart';
import '../../widgets/launch_button.dart';
import '../../widgets/map_page.dart';
import '../../widgets/star_and_comment.dart';
import '../admin_corporate_panel/corporation_analysis/corporation_analysis_view_model.dart';
import '../comments/comments_view.dart';
import '../fav_products/fav_products_view_model.dart';
import '../join/join_view.dart';
import '../reservation/reservation_view_model.dart';
import '../select-orders/calender/calendar_view.dart';
import '../select-orders/properties/order_view_model.dart';
import 'package:photo_view/photo_view.dart';

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
  bool mapVisibility;
  String buttonText;
  String buttonMapText;
  IconData icon = Icons.keyboard_arrow_down;
  String districtName = "";
  String regionName = "";
  CorporationEventLogModel corporationEventLogModel;
  bool hasDataTaken = false;
  bool hasFillOrderViewParamsTaken = false;
  bool hasDistrictsAndRegionTaken = false;

  @override
  void initState() {
    getDistrictRegionName(int.parse(widget.corporationModel.district), int.parse(widget.corporationModel.region));
    calenderVisibility = false;
    mapVisibility = false;
    buttonText = "Takvimi Göster";
    buttonMapText = "Haritayı Göster";
    callGetImageList();
    callGetHashtagListList();
    callGetReservationList();
    callGetProductComments();
    fillOrderViewParams();
    logData();
    getLogModel();
    super.initState();
  }

  Future<void> getDistrictRegionName(int districtId, int regionId) async{
    ProductsViewDetailModel productsViewDetailModel = ProductsViewDetailModel();
    districtName = await productsViewDetailModel.getDistrict(districtId);
    regionName = await productsViewDetailModel.getRegion(regionId);

    districtName = districtName.substring(1);
    regionName = regionName.substring(1);
    setState(() {
      hasDistrictsAndRegionTaken = true;
    });
  }

  void getLogModel() async {
    CorporationAnalysisViewModel corporationAnalysisViewModel = CorporationAnalysisViewModel();
    corporationEventLogModel = await corporationAnalysisViewModel.getLogForScreen(widget.corporationModel.corporationId);
    setState(() {
      corporationEventLogModel = corporationEventLogModel;
      hasDataTaken = true;
    });
  }

  void logData() async {
    CorporationAnalysisViewModel corporationAnalysisViewModel = CorporationAnalysisViewModel();
    await corporationAnalysisViewModel.editDailyLog(widget.corporationModel.corporationId, CorporationEventLogEnum.newVisit.name, 0);
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
      hasFillOrderViewParamsTaken = true;
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
      isFavorite = UserState.isCorporationFavorite(widget.corporationModel.corporationId);
    });
  }

  void pushToJoinPage(BuildContext context) {
    Utils.navigateToPage(context, JoinView(childPage: new ProductDetails(corporationModel: widget.corporationModel)));
  }

  void _launchMapsUrl(double latitude, double longitude) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    void openGallery(final List<String> imglist, final int index) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => GalleryWidget(
      imageList: imglist,
      index: index,
    ),));

    if (!hasDataTaken || !hasFillOrderViewParamsTaken || !hasDistrictsAndRegionTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: widget.corporationModel.corporationName, isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: Indicator())));
    }

    Widget corpNameWidget = Text(
      widget.corporationModel.corporationName,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w800,
      ),
      maxLines: 2,
    );
    if(widget.corporationModel.isPopularCorporation){
      setState(() {
        corpNameWidget = FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BounceButton(
                child: Image.asset("assets/sponsorship_smaller.png"),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Davetcim Sponsoru", style: TextStyle(fontSize: 17, color: Colors.black)),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.white.withOpacity(0.5), // Arka planı transparan beyaz yapar
                    ),
                  );
                },
                height: MediaQuery.of(context).size.height / 17,
                width: MediaQuery.of(context).size.width / 10,
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent, // Gündüz modunda transparan siyah
                ),
              ),

              Text(
                widget.corporationModel.corporationName,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
              ),
            ],
          ),
        );
      });

    }

    isFavorite = UserState.isCorporationFavorite(widget.corporationModel.corporationId);

    Widget img = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3.2,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            //       !loading ? HomeCarousel(homeManager) : Center(child:ProgressIndicator())
            child: Swiper(
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                    child: Image.network(imageList[index],fit: BoxFit.fill,),
                  onTap: (){
                    openGallery(imageList, index);
                    //Utils.navigateToPage(context, ImageDetailScreen(corporationModel: widget.corporationModel, image: imageList[index],));
                  },
                );
              },
              itemCount: imageList.length,
              pagination: SwiperPagination(),
              control: SwiperControl(),
              autoplay: true,
              duration: 1500, // Swipe işlemi için animasyon süresi (opsiyonel)
              autoplayDelay: 5000, // Otomatik dönme arasındaki bekleme süresi (5 saniye)
            ),
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
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Yuvarlak şekil
              color: Colors.white70, // Düğme rengi
            ),
          ),
        ),
      ],
    );
    if(widget.corporationModel.imageUrl == null || widget.corporationModel.imageUrl.isEmpty ){
      img = Icon(
        Icons.home_filled,
        size: 150.0,
        color: Colors.redAccent,
      );
    }

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
                  img,
                  SizedBox(height:MediaQuery.of(context).size.height/50,),
                  corpNameWidget,
                  HashtagWidget(hashtagList: hashtagList),
                  SizedBox(height: MediaQuery.of(context).size.height/50,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: FittedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  SmoothStarRating(
                                    starCount: 5,
                                    color: Constants.ratingBG,
                                    allowHalfRating: true,
                                    rating: widget.corporationModel.averageRating,
                                    size: 30,
                                    borderColor: Constants.ratingBG,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "("+GeneralHelper.formatMoney(widget.corporationModel.ratingCount.toString())  + ' Değerlendirme)',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.redAccent
                                        ),
                                      ),
                                    ],
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
                                    GeneralHelper.formatMoney(widget.corporationModel.maxPopulation.toString()) ,
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
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/50,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              child: ListTile(
                                trailing: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.visibility,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                subtitle: Text(
                                  "Salonun detay sayfasının kaç kere incelendiği bilgisini içerir.",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                  ),
                                ),
                                title: Text(
                                  "Ziyaretçi Sayısı",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0
                                  ),
                                ),
                              ),
                            ),
                            Divider(color: Colors.redAccent, thickness: 1),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Text(
                                      "Bugün",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.deepOrange
                                      ),
                                    ),
                                    Text(
                                      GeneralHelper.formatMoney(corporationEventLogModel.visitCount.toString()),
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.deepOrangeAccent
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Son 1 Ay",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.deepOrange
                                      ),
                                    ),
                                    Text(
                                        GeneralHelper.formatMoney(corporationEventLogModel.visitCountMonth.toString()) ,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.deepOrangeAccent
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Son 1 Yıl",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.deepOrange
                                      ),
                                    ),
                                    Text(
                                      GeneralHelper.formatMoney(corporationEventLogModel.visitCountYear.toString()),
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.deepOrangeAccent
                                      ),
                                    ),
                                  ],
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
                      child: FittedBox(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              LaunchButton(
                                title: 'Telefon',
                                value: widget.corporationModel.telephoneNo,
                                icon: Icons.phone,
                                color: Colors.green,
                                context: context,
                                onPressed: () async {
                                  Uri uri = Uri.parse('tel:' + widget.corporationModel.telephoneNo);
                                  if (!await launcher.launchUrl(uri)) {
                                    debugPrint(
                                        "Could not launch the uri"); // because the simulator doesn't has the phone app
                                  }
                                },
                              ),
                              SizedBox(width: 16.0), // İkinci düğme ile arasında boşluk bırakın
                              LaunchButton(
                                title: 'Email',
                                value: widget.corporationModel.email,
                                icon: Icons.mail,
                                color: Colors.blueAccent,
                                context: context,
                                onPressed: () async {
                                  Uri uri = Uri.parse(
                                    'mailto:' + widget.corporationModel.email + '?subject=Davetcim Rezervasyonu HK.&body=Merhaba,',
                                  );
                                  if (!await launcher.launchUrl(uri)) {
                                    debugPrint(
                                        "Could not launch the uri"); // because the simulator doesn't has the email app
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height/30),
                  Card(
                    elevation: 10,
                    shadowColor: Colors.redAccent,
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
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
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          child: SelectLocationPage(widget.corporationModel.latitude, widget.corporationModel.longitude),
                        ),
                        SizedBox(height: 3), // İstenilen boşluk miktarına göre ayarlayın
                        Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              double latitude = widget.corporationModel.latitude;
                              double longitude = widget.corporationModel.longitude;

                              // Google Haritalar'a belirli bir latitude ve longitude ile bir yönlendirme yapmak için
                              _launchMapsUrl(latitude, longitude);
                            },
                            icon: Icon(Icons.navigation), // Navigasyon ikonu ekleyin
                            label: Text('Haritada Görüntüle'), // Düğme metni
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue, // Düğme arka plan rengi
                              onPrimary: Colors.white, // Düğme metin rengi
                              shape: RoundedRectangleBorder( // Düğme şekli
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 4, // Yükseltme
                            ),
                          ),
                        ),

                      ],
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
                      BounceButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(buttonText, style: TextStyle(fontSize: 18, color: Colors.white),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(icon, size: 22, color: Colors.white),
                            ),
                          ],
                        ),
                        onTap: (){
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
                        height: MediaQuery.of(context).size.height/15,
                        width: MediaQuery.of(context).size.height/1,
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(5)
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
                                  ),
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
            onPressed: ()  {
              if (UserState.isPresent() && UserState.corporationId != widget.corporationModel.corporationId) {
                UserBasketState.set(widget.corporationModel, sequenceOrderList, invitationList, reservationList);
                Utils.navigateToPage(context, CalendarScreen());
              } else  if (UserState.isPresent() && UserState.corporationId == widget.corporationModel.corporationId) {
                Dialogs.showInfoModalContent(
                    context,
                    "Rezervasyon Uyarısı",
                    "Kullanıcısı olduğunuz salona rezervasyon yapamazsınız.",
                    null);
              } else {
                Dialogs.showInfoModalContent(
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

class ImageDetailScreen extends StatefulWidget {
  final CorporationModel corporationModel;
  final String image;

  ImageDetailScreen({Key key, @required this.corporationModel, @required this.image}) : super(key: key);

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  double _scale = 0.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: PhotoView(
            imageProvider: NetworkImage(widget.image),
            minScale: 0.5,
            maxScale: 3.0,
            initialScale: _scale,
            backgroundDecoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ),
        onScaleStart: (ScaleStartDetails details) {
          setState(() {
            _previousScale = _scale;
          });
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            _scale = _previousScale * details.scale;
          });
        },
        onScaleEnd: (ScaleEndDetails details) {
          setState(() {
            _previousScale = _scale.clamp(0.5, 3.0);
          });
        },
        onTap: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final List<String> imageList;
  final int index;

  GalleryWidget({Key key, @required this.imageList, @required this.index = 0})
      : pageController = PageController(initialPage: index),
        super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidget();
}

class _GalleryWidget extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        /*onVerticalDragEnd: (details){
            Navigator.of(context).pop();
          },
        onTapUp: (details){
          Navigator.of(context).pop();
        },*/
        behavior: HitTestBehavior.translucent,
        onVerticalDragUpdate: (details) {
          // Aşağı kaydırma hassasiyeti
          int sensitivity = 8;
          // Aşağı kaydırma hareketi kontrolü
          if (details.delta.dy > sensitivity) {
            // Aşağı kaydırma işlemi algılandı, SearchScreen açılıyor
            Navigator.pop(context, PageTransition(type: PageTransitionType.topToBottom, ));
          }
        },
        onTap: (){
          Navigator.pop(context, PageTransition(type: PageTransitionType.topToBottom, ));
        },

        child: Stack(
          children: [
            PhotoViewGallery.builder(
              pageController: widget.pageController,
              itemCount: widget.imageList.length,
              builder: (context, index) {
                final urlImage = widget.imageList[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(urlImage),
                );
              },
            ),
            Center(
              child: Text(
                "Davetcim",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.3), // Metnin rengi ve şeffaflığı
                  fontSize: 40, // Metnin boyutu
                  fontWeight: FontWeight.bold, // Metnin kalınlığı
                ),
              ),
            ),
          ],
        ),



      ),
    );
  }
}
