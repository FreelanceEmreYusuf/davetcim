import 'package:davetcim/shared/helpers/general_helper.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/src/select-orders/summary_basket/summary_basket_view_model.dart';
import 'package:flutter/material.dart';
import '../../../shared/enums/dialog_input_validator_type_enum.dart';
import '../../../shared/helpers/pdf_helper.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/sessions/state_management.dart';
import '../../../shared/sessions/user_basket_state.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/dialogs.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_corporate_service_pool_for_basket_summary.dart';
import '../../notifications/notifications_view_model.dart';

class SummaryBasketScreen extends StatefulWidget {
  @override
  _SummaryBasketScreenState createState() => _SummaryBasketScreenState();
}

class _SummaryBasketScreenState extends State<SummaryBasketScreen>
    with AutomaticKeepAliveClientMixin<SummaryBasketScreen> {


  List<ServicePoolModel> updateServiceList(List<ServicePoolModel> serviceList){
    for(int i=0; i<serviceList.length; i++){
          serviceList.removeWhere((item) => item.companyHasService == false && item.hasChild != true);
    }
    return serviceList;
  }

  int calculateTotalPrice(){
    int totalPrice = 0;
    totalPrice += int.parse(calculateSessionPrice());
    if (UserBasketState.userBasket.servicePoolModel != null) {
      for(int i =0; i < UserBasketState.userBasket.servicePoolModel.length;i++){
        if(UserBasketState.userBasket.servicePoolModel[i].corporateDetail.priceChangedForCount){
          totalPrice += UserBasketState.userBasket.orderBasketModel.count * UserBasketState.userBasket.servicePoolModel[i].corporateDetail.price;
        }
        else{
          totalPrice += UserBasketState.userBasket.servicePoolModel[i].corporateDetail.price;
        }
      }
    }
    if (UserBasketState.userBasket.packageModel != null) {
      totalPrice += UserBasketState.userBasket.orderBasketModel.count *  UserBasketState.userBasket.packageModel.price;
    }

    UserBasketState.userBasket.totalPrice = totalPrice;
    return totalPrice;
  }

  String calculateSessionPrice(){
    int sessionCost = 0;
      if(DateConversionUtils.isWeekendFromIntDate(UserBasketState.userBasket.date) ){
        sessionCost = UserBasketState.userBasket.selectedSessionModel.weekendPrice;
      }
      else{
        sessionCost = UserBasketState.userBasket.selectedSessionModel.midweekPrice;
      }

      return sessionCost.toString();
  }

  @override
  void initState() {
    super.initState();
    calculateSessionPrice();
  }

  Widget getPackageWidget() {
    if (UserBasketState.userBasket.packageModel != null) {
      return
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 10,
            color: Colors.white54,
            child: Row(
                children: [
              Expanded(
                flex: 3,
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  UserBasketState.userBasket.packageModel.title,
                  style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 13, MediaQuery.of(context).size.height / 13),
              child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0)),
              //circular(30.0), // Yuvarlak köşe için bir değer belirtin
              child: Material(
              color: Colors.grey,
              child: InkWell(
              splashColor: Colors.deepOrangeAccent,
              onTap: () async {
                Dialogs.showInfoModalContent(
                context,
                UserBasketState.userBasket.packageModel.title,
                "Paket İçeriği: "+UserBasketState.userBasket.packageModel.body+""
                "\n\nKişi başı ücret: "+GeneralHelper.formatMoney(UserBasketState.userBasket.packageModel.price.toString())+" TL"
                "\n\nDavetli Sayısına Göre Toplam Tutar: "
                "\nDavetli Sayısı("+UserBasketState.userBasket.orderBasketModel.count.toString()+") "
                "\nKişi Başı Paket Ücreti("+GeneralHelper.formatMoney(UserBasketState.userBasket.packageModel.price.toString())+"TL)"
                "\nToplam Ücret: "+GeneralHelper.formatMoney((UserBasketState.userBasket.packageModel.price*UserBasketState.userBasket.orderBasketModel.count).toString())+" TL",
                null);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(child: Icon(Icons.info_outline, color: Colors.white)),
                  FittedBox(child: Text("Bilgi", style: TextStyle(color: Colors.white))),
                ],
              ),
              ),
              ),
              ),
            ),
          ),
          ],
          ),
          ),
          );
    }

    return Container(
        child: Text("Paket Seçimi Bulunmamaktadır.", style: TextStyle(color: Colors.red)),
        padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
    );
  }

  Widget getServiceWidget() {
    if (UserBasketState.userBasket.servicePoolModel != null) {
      return GridView.builder(
        shrinkWrap: true,
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 12),
        ),
        itemCount: UserBasketState.userBasket.servicePoolModel == null
            ? 0
            : UserBasketState.userBasket.servicePoolModel.length,
        itemBuilder: (BuildContext context, int index) {
          ServicePoolModel item = UserBasketState.userBasket.servicePoolModel[index];

          return GridCorporateServicePoolForBasketSummary(servicePoolModel: item);
        },
      );
    }

    return Container(
        child: Expanded(child: Text("Hizmet Seçimi Bulunmamaktadır.", style: TextStyle(color: Colors.red))),
        padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBarMenu(pageName: "Teklif Özeti", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/filter_page_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.1), // Filtre yoğunluğu
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              //Tarih ve seans
              SizedBox(height: 10.0),
              Container(
                height: MediaQuery.of(context).size.height / 13,
                child: Card(
                  color: Colors.redAccent,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shadowColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                            " TARİH & SEANS", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width /20,
                  child: Card(
                    elevation: 10,
                    color: Colors.white54,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Tarih : "+DateConversionUtils.getDateTimeFromIntDate(UserBasketState.userBasket.date).toString().substring(0,10)
                                    +"\n\nSeans : "+UserBasketState.userBasket.selectedSessionModel.name,
                                style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox.fromSize(
                            size: Size(MediaQuery.of(context).size.height / 13, MediaQuery.of(context).size.height / 13),
                            child: ClipRRect(
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0)),
                              //circular(30.0), // Yuvarlak köşe için bir değer belirtin
                              child: Material(
                                color: Colors.grey,
                                child: InkWell(
                                  splashColor: Colors.deepOrangeAccent,
                                  onTap: () async {
                                    Dialogs.showInfoModalContent(context,
                                        UserBasketState.userBasket.selectedSessionModel.name,
                                        "Organizasyon tarihi : " +
                                            DateConversionUtils.getDateTimeFromIntDate(UserBasketState.userBasket.date).toString().substring(0, 10) +
                                            "\n\nSeans : " + UserBasketState.userBasket.selectedSessionModel.name +
                                            "\n\nBu seans için alınan hizmetler hariç salon kullanımı için ödenecek ücret : " +
                                            GeneralHelper.formatMoney(calculateSessionPrice()) +
                                            "TL", null);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FittedBox(child: Icon(Icons.info_outline, color: Colors.white)),
                                      FittedBox(child: Text("Bilgi", style: TextStyle(color: Colors.white))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //order list
              SizedBox(height: 10.0),
              Container(
                height: MediaQuery.of(context).size.height / 13,
                child: Card(
                  color: Colors.redAccent,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shadowColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                            " ORGANİZASYON DETAYLARI", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  color: Colors.white54,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Davetli Sayısı :" + UserBasketState.userBasket.orderBasketModel.count.toString()
                               +"\n\nDavet türü : "+ UserBasketState.userBasket.orderBasketModel.invitationType
                               +"\n\nOturma düzeni : "+ UserBasketState.userBasket.orderBasketModel.sequenceOrder,
                              style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox.fromSize(
                          size: Size(MediaQuery.of(context).size.height / 13, MediaQuery.of(context).size.height / 13),
                          child: ClipRRect(
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0)),
                            //circular(30.0), // Yuvarlak köşe için bir değer belirtin
                            child: Material(
                              color: Colors.grey,
                              child: InkWell(
                                splashColor: Colors.deepOrangeAccent,
                                onTap: () async {
                                  Dialogs.showInfoModalContent(context,
                                      "Bilgi",
                                      "Organizsayon ücretini oluşturan birçok hizmet kalemi, davetli sayısına bağlı olarak artabilmektedir.",
                                      null);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FittedBox(child: Icon(Icons.info_outline, color: Colors.white)),
                                    FittedBox(child: Text("Bilgi", style: TextStyle(color: Colors.white))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //paket seçimi
              Divider(),
              Container(
                height: MediaQuery.of(context).size.height / 13,
                child: Card(
                  color: Colors.redAccent,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shadowColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                            " PAKET SEÇİMİ", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              getPackageWidget(),
              //hizmetler
              SizedBox(height: 10.0),
              Container(
                height: MediaQuery.of(context).size.height / 13,
                child: Card(
                  color: Colors.redAccent,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shadowColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "HİZMETLER", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              getServiceWidget(),
              SizedBox(height: 10.0),
              Positioned(
                bottom: MediaQuery.of(context).size.height / 150,
                right: MediaQuery.of(context).size.width / 150,
                left: MediaQuery.of(context).size.width / 150,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: ()  {
                      PDFHelper pdfHelper = PDFHelper();
                      pdfHelper.createAndShowOfferPDF(context);
                    },
                    child: Text(
                      "TEKLİF İÇİN PDF GÖSTER".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 5,),

            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: double.infinity, // Card'ın genişliği ekrana sığacak şekilde ayarlanır
        child: Card(
          color: Colors.redAccent,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shadowColor: Colors.black,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Metinler arasında boşluk olması için MainAxisAlignment.spaceBetween kullanılır
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width / 40,),
                Expanded(
                  child: Text(
                    "Toplam Tutar :",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    " " + GeneralHelper.formatMoney(calculateTotalPrice().toString()) + " TL ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(5.0),
        height: 50.0,
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.redAccent,),
          child: Text(
            "TEKLİFİ ONAYLA",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: ()  {
            int minReservationAmount = UserBasketState.userBasket.corporationModel.minReservationAmount;
            if(DateConversionUtils.isWeekendFromIntDate(UserBasketState.userBasket.date) ){
              minReservationAmount = UserBasketState.userBasket.corporationModel.minReservationAmountWeekend;
            }

            if (minReservationAmount < calculateTotalPrice()) {
              Dialogs.showDialogModalContentWithInputBox(context, "Sepet Mesajı", "İptal", "Sepeti Onayla", "Mesajınızı Girin", 10,
                  createReservationRequest, DailogInmputValidatorTypeEnum.richText, lineCount: 2);
            } else {
              Dialogs.showInfoModalContent(
                  context,
                  "Uyarı",
                  "Minimum rezervasyon tutarı; bu salon ve belirlenen tarih için " + GeneralHelper.formatMoney(minReservationAmount.toString()) + " TL dir",
                  null);
            }
          },
        ),
      ),
    );
  }

  void createReservationRequest(String description) async{
    UserBasketState.userBasket.servicePoolModel = UserBasketState.servicePoolModel;

    SummaryBasketViewModel model = SummaryBasketViewModel();
    ReservationModel reservationResponse = await model.createNewReservation(UserBasketState.userBasket, description);
    if (reservationResponse == null) {
      Dialogs.showInfoModalContent(context, "Üzgünüz", "Siz teklif oluştururken başka bir kullanıcı tarafından bu tarihteki bu seans rezerve edildi.", null);
    } else {
      NotificationsViewModel notificationViewModel = NotificationsViewModel();
      notificationViewModel.sendNotificationsToAdminCompanyUsers(context, UserBasketState.userBasket.corporationModel.corporationId,
          0, reservationResponse.id,  description);
      Dialogs.showInfoModalContent(context, "İşlem Mesajı", "Teklifiniz alınmıştır. Salon sahibine bildirim gönderilmiştir.", navigateToHomePage);
      StateManagement.disposeStates();
    }
  }

  void navigateToHomePage(BuildContext context) {
    StateManagement.disposeStates();
    Utils.navigateToPage(context, MainScreen());
  }

  @override
  bool get wantKeepAlive => true;
}
