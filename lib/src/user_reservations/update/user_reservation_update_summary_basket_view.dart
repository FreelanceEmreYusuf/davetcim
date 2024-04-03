import 'package:davetcim/shared/sessions/reservation_edit_state.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:flutter/material.dart';
import '../../../shared/enums/dialog_input_validator_type_enum.dart';
import '../../../shared/helpers/general_helper.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/sessions/user_basket_state.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/dialogs.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/user_reservation_update_grid_corporate_service_pool_for_basket_summary.dart';
import '../../select-orders/summary_basket/summary_basket_view_model.dart';
import '../user_reservations_with_app_bar_view.dart';

class UserReservationUpdateSummaryBasketScreen extends StatefulWidget {
  @override
  _UserReservationUpdateSummaryBasketScreenState createState() => _UserReservationUpdateSummaryBasketScreenState();
}

class _UserReservationUpdateSummaryBasketScreenState extends State<UserReservationUpdateSummaryBasketScreen>
    with AutomaticKeepAliveClientMixin<UserReservationUpdateSummaryBasketScreen> {

  List<ServicePoolModel> updateServiceList(List<ServicePoolModel> serviceList){
    for(int i=0; i<serviceList.length; i++){
          serviceList.removeWhere((item) => item.companyHasService == false && item.hasChild != true);
    }
    return serviceList;
  }

  int calculateTotalPrice(){
    int totalPrice = 0;
    totalPrice += int.parse(calculateSessionPrice());
    if (ReservationEditState.reservationDetail.servicePoolModel != null) {
      for(int i =0; i < ReservationEditState.reservationDetail.servicePoolModel.length;i++){
        if(ReservationEditState.reservationDetail.servicePoolModel[i].corporateDetail.priceChangedForCount) {
          totalPrice += ReservationEditState.reservationDetail.orderBasketModel.count *
              ReservationEditState.reservationDetail.servicePoolModel[i].corporateDetail.price;
        }
        else{
          totalPrice += ReservationEditState.reservationDetail.servicePoolModel[i].corporateDetail.price;
        }
      }
    }
    if (ReservationEditState.reservationDetail.packageModel != null) {
      totalPrice += ReservationEditState.reservationDetail.orderBasketModel.count *
          ReservationEditState.reservationDetail.packageModel.price;
    }

    ReservationEditState.reservationDetail.reservationModel.cost = totalPrice;
    return totalPrice;
  }

  String calculateSessionPrice(){
    int sessionCost = 0;
      if(DateConversionUtils.isWeekendFromIntDate(ReservationEditState.reservationDetail.reservationModel.date) ){
        sessionCost = ReservationEditState.reservationDetail.selectedSessionModel.weekendPrice;
      }
      else{
        sessionCost = ReservationEditState.reservationDetail.selectedSessionModel.midweekPrice;
      }

      return sessionCost.toString();
  }

  @override
  void initState() {
    super.initState();
    calculateSessionPrice();
  }

  Widget getPackageWidget() {
    if (ReservationEditState.reservationDetail.packageModel != null) {
      return
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 10,
            color: Colors.white54,
            child: Row(
                children: [
              FittedBox(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  ReservationEditState.reservationDetail.packageModel.title,
                  style: TextStyle(fontSize: 16, color: Colors.black,
                    fontStyle: FontStyle.normal,fontWeight: FontWeight.bold)
              ),
            ),
          ),
          Spacer(),
          SizedBox.fromSize(
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
                  ReservationEditState.reservationDetail.packageModel.title,
              "Paket İçeriği: "+ReservationEditState.reservationDetail.packageModel.body+""
              "\n\nKişi başı ücret: "+GeneralHelper.formatMoney(ReservationEditState.reservationDetail.packageModel.price.toString())+" TL"
              "\n\nDavetli Sayısına Göre Toplam Tutar: "
              "\nDavetli Sayısı("+ReservationEditState.reservationDetail.orderBasketModel.count.toString()+") "
              "\nKişi Başı Paket Ücreti("+GeneralHelper.formatMoney(ReservationEditState.reservationDetail.packageModel.price.toString())+"TL)"
              "\nToplam Ücret: "+GeneralHelper.formatMoney((ReservationEditState.reservationDetail.packageModel.price*
                  ReservationEditState.reservationDetail.orderBasketModel.count).toString())+" TL",
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
    if (ReservationEditState.reservationDetail.servicePoolModel != null) {
      return GridView.builder(
        shrinkWrap: true,
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 12),
        ),
        itemCount: ReservationEditState.reservationDetail.servicePoolModel == null
            ? 0
            : ReservationEditState.reservationDetail.servicePoolModel.length,
        itemBuilder: (BuildContext context, int index) {
          ServicePoolModel item = ReservationEditState.reservationDetail.servicePoolModel[index];

          return UserReservationUpdateGridCorporateServicePoolForBasketSummary(servicePoolModel: item);
        },
      );
    }

    return Container(
        child: Text("Hizmet Seçimi Bulunmamaktadır.", style: TextStyle(color: Colors.red)),
        padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBarMenu(pageName: "Sepet Özeti", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
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
                    FittedBox(
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
                      FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Tarih : "+DateConversionUtils.getDateTimeFromIntDate(
                                  ReservationEditState.reservationDetail.reservationModel.date).toString().substring(0,10)
                                  +"\n\nSeans : "+
                                  ReservationEditState.reservationDetail.selectedSessionModel.name,
                              style: TextStyle(fontSize: 16, color: Colors.black,
                                fontStyle: FontStyle.normal,fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                      Spacer(),
                      SizedBox.fromSize(
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
                                  ReservationEditState.reservationDetail.selectedSessionModel.name,
                                  "Organizasyon tarihi : " +
                                      DateConversionUtils.getDateTimeFromIntDate(
                                          ReservationEditState.reservationDetail.reservationModel.date).toString().substring(0, 10) +
                                      "\n\nSeans : " + ReservationEditState.reservationDetail.selectedSessionModel.name +
                                      "\n\nBu tarih için alınan hizmetler hariç salon kullanımı için ödenecek seans ücreti : " +
                                    GeneralHelper.formatMoney(calculateSessionPrice()) +
                                      "TL",
                                  null,
                                );
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
                    FittedBox(
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
                    FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Davetli Sayısı :" + ReservationEditState.reservationDetail.orderBasketModel.count.toString()
                             +"\n\nDavet türü : "+ ReservationEditState.reservationDetail.orderBasketModel.invitationType
                             +"\n\nOturma düzeni : "+ ReservationEditState.reservationDetail.orderBasketModel.sequenceOrder,
                            style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox.fromSize(
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
                    FittedBox(
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
                    FittedBox(
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
            SizedBox(height: MediaQuery.of(context).size.height / 5,),

          ],
        ),
      ),
      floatingActionButton: Container(
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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "Toplam Tutar :", style: TextStyle(fontSize: 20, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
              SizedBox(width: MediaQuery.of(context).size.width /4),
              Text(
                  " "+calculateTotalPrice().toString()+" TL ", style: TextStyle(fontSize: 20, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(5.0),
        height: 50.0,
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.redAccent,),
          child: Text(
            "GÜNCELLE",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: ()  {
            int minReservationAmount = ReservationEditState.reservationDetail.corporateModel.minReservationAmount;
            if(DateConversionUtils.isWeekendFromIntDate(ReservationEditState.reservationDetail.reservationModel.date) ){
              minReservationAmount = ReservationEditState.reservationDetail.corporateModel.minReservationAmountWeekend;
            }

            if (minReservationAmount < calculateTotalPrice()) {
              Dialogs.showDialogMessageWithInputBox(context, "Sepet Mesajı", "İptal", "Sepeti Onayla", "Mesajınızı Girin", 10,
                  createReservationRequest, DailogInmputValidatorTypeEnum.richText);
            } else {
              Dialogs.showInfoModalContent(
                  context,
                  "Uyarı",
                  "Minimum rezervasyon tutarı; bu salon ve belirlenen tarih için " + minReservationAmount.toString() + " TL dir",
                  null);
            }
          },
        ),
      ),
    );
  }

  void createReservationRequest(String description) async{
    ReservationEditState.reservationDetail.servicePoolModel = UserBasketState.servicePoolModel;

    SummaryBasketViewModel model = SummaryBasketViewModel();
    ReservationModel reservationResponse = await model.updateUserReservation(
        ReservationEditState.reservationDetail, description);
    if (reservationResponse == null) {
      Dialogs.showInfoModalContent(context, "Üzgünüz", "Siz rezervasyon yaparken rezervasyonunuz onaylandı ya da red edildi.Salon sahibiyle iletişime geçiniz",
          navigateToReservationsPage);
    } else {
      Dialogs.showInfoModalContent(context, "İşlem Mesajı", "Rezervasyon talebiniz güncellenmiştir.", navigateToHomePage);
    }
  }

  void navigateToHomePage(BuildContext context) {
    UserBasketState.servicePoolModel = [];
    Utils.navigateToPage(context, MainScreen());
  }

  void navigateToReservationsPage(BuildContext context) {
    UserBasketState.servicePoolModel = [];
    Utils.navigateToPage(context, UserReservationsWithAppBarScreen());
  }

  @override
  bool get wantKeepAlive => true;
}
