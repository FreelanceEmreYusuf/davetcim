import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/src/select-orders/summary_basket/summary_basket_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared/dto/basket_user_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/sessions/user_basket_session.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/dialogs.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_corporate_service_pool_for_basket.dart';
import '../../../widgets/grid_corporate_service_pool_for_basket_summary.dart';
import '../../admin_corporate_panel/service/service-corporate_view_model.dart';
import '../../notifications/notifications_view_model.dart';

class SummaryBasketScreen extends StatefulWidget {
  @override
  _SummaryBasketScreenState createState() => _SummaryBasketScreenState();
  final BasketUserModel basketModel;

  SummaryBasketScreen(
      {Key key,
        @required this.basketModel,
      })
      : super(key: key);

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
    for(int i =0; i<widget.basketModel.servicePoolModel.length;i++){
      if(widget.basketModel.servicePoolModel[i].corporateDetail.priceChangedForCount){
        totalPrice += widget.basketModel.orderBasketModel.count * widget.basketModel.servicePoolModel[i].corporateDetail.price;
      }
      else{
        totalPrice += widget.basketModel.servicePoolModel[i].corporateDetail.price;
      }
    }
    widget.basketModel.totalPrice = totalPrice;
    return totalPrice;
  }

  String calculateSessionPrice(){
    int sessionCost = 0;
      if(DateConversionUtils.isWeekendFromIntDate(widget.basketModel.date) ){
        sessionCost = widget.basketModel.selectedSessionModel.weekendPrice;
      }
      else{
        sessionCost = widget.basketModel.selectedSessionModel.midweekPrice;
      }

      return sessionCost.toString();
  }

  @override
  void initState() {
    super.initState();
    calculateSessionPrice();
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        " TARİH & SEANS", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                  ],
                ),
              ),
            ),
            Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  color: Colors.white54,
                  child: Row(
                    children: [
                      Text(
                          "Tarih : "+DateConversionUtils.getDateTimeFromIntDate(widget.basketModel.date).toString().substring(0,10)
                              +"\n\nSeans : "+widget.basketModel.selectedSessionModel.name,
                          style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                      ),
                      Spacer(),
                      SizedBox.fromSize(
                        size: Size(MediaQuery.of(context).size.height / 10, MediaQuery.of(context).size.height / 10), // button width and height
                        child: ClipPath(
                          child: Material(
                            color: Colors.grey, // button color
                            child: InkWell(
                              splashColor: Colors.deepOrangeAccent, // splash color
                              onTap: () async {
                                //TODO: widget.basketModel.sessionModel doğru gelmiyor ne seçersek seçelim Gece Seansı - 23:00 - 03:00
                                Dialogs.showAlertMessageWithAction(
                                    context,
                                    widget.basketModel.selectedSessionModel.name,
                                    "Organizasyon tarihi : "+DateConversionUtils.getDateTimeFromIntDate(widget.basketModel.date).toString().substring(0,10)
                                        +"\n\nSeans : "+ widget.basketModel.selectedSessionModel.name
                                        +"\n\nBu tarih için alınan hizmetler hariç salon kullanımı için ödenecek seans ücreti : "+ calculateSessionPrice()+ "TL",
                                    null);
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.info_outline, color: Colors.white), // icon
                                  Text("Bilgi", style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /*Container(
                  height: MediaQuery.of(context).size.height / 13,
                  child: Card(
                    color: Colors.white54,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shadowColor: Colors.black,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            DateConversionUtils.getDateTimeFromIntDate(widget.basketModel.date).toString().substring(0,10)
                                +" & "+widget.basketModel.sessionModel.name,
                            style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                        ),
                      ],
                    ),
                  ),
                ),*/
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        " ORGANİZASYON DETAYLARI", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
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
                    Text(
                        "Davetli Sayısı :" + widget.basketModel.orderBasketModel.count.toString()
                         +"\n\nDavet türü : "+ widget.basketModel.orderBasketModel.invitationType
                         +"\n\nOturma düzeni : "+ widget.basketModel.orderBasketModel.sequenceOrder,
                        style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                    ),
                    Spacer(),
                    SizedBox.fromSize(
                      size: Size(MediaQuery.of(context).size.height / 10, MediaQuery.of(context).size.height / 7), // button width and height
                      child: ClipPath(
                        child: Material(
                          color: Colors.grey, // button color
                          child: InkWell(
                            splashColor: Colors.deepOrangeAccent, // splash color
                            onTap: () async {
                              //TODO: widget.basketModel.sessionModel doğru gelmiyor ne seçersek seçelim Gece Seansı - 23:00 - 03:00
                              Dialogs.showAlertMessageWithAction(
                                  context,
                                  "Bilgi",
                                  "Organizsayon ücretini oluşturan birçok hizmet kalemi, davetli sayısına bağlı olarak artabilmektedir.",
                                  null);
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.info_outline, color: Colors.white), // icon
                                Text("Bilgi", style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /*Container(
                height: MediaQuery.of(context).size.height / 13,
                child: Card(
                  color: Colors.white54,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shadowColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          DateConversionUtils.getDateTimeFromIntDate(widget.basketModel.date).toString().substring(0,10)
                              +" & "+widget.basketModel.sessionModel.name,
                          style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                      ),
                    ],
                  ),
                ),
              ),*/
            ),

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
                    Text(
                        "HİZMETLER", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                  ],
                ),
              ),
            ),
            Divider(),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 12),
              ),
              itemCount: widget.basketModel.servicePoolModel == null
                  ? 0
                  : widget.basketModel.servicePoolModel.length,
              itemBuilder: (BuildContext context, int index) {
                ServicePoolModel item = widget.basketModel.servicePoolModel[index];

                return GridCorporateServicePoolForBasketSummary(servicePoolModel: item, basketModel: widget.basketModel,);
              },
            ),
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
            "SEPETİ ONAYLA",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Dialogs.showDialogMessageWithInputBox(context, "Sepet Mesajı", createReservationRequest);
          },
        ),
      ),
    );
  }

  void createReservationRequest(String description) async{
    widget.basketModel.servicePoolModel = UserBasketSession.servicePoolModel;

    SummaryBasketViewModel model = SummaryBasketViewModel();
    ReservationModel reservationResponse = await model.createNewReservation(widget.basketModel, description);
    if (reservationResponse == null) {
      Dialogs.showAlertMessage(context, "Üzgünüz", "Siz rezervasyon yaparken başka bir kullanıcı tarafından bu tarihteki bu seans rezerve edildi.");
    } else {
      NotificationsViewModel notificationViewModel = NotificationsViewModel();
      notificationViewModel.sendNotificationsToAdminCompanyUsers(context, widget.basketModel.corporationId, 0, reservationResponse.id,  description);
      Dialogs.showAlertMessageWithAction(context, "İşlem Mesajı", "Rezervasyon talebiniz alınmıştır. Salon sahibine bildirim gönderilmiştir.", navigateToHomePage);
    }
  }

  void navigateToHomePage(BuildContext context) {
    UserBasketSession.servicePoolModel = [];
    Utils.navigateToPage(context, MainScreen());
  }

  @override
  bool get wantKeepAlive => true;
}
