import 'package:davetcim/shared/enums/reservation_status_enum.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/src/select-orders/summary_basket/summary_basket_view_model.dart';
import 'package:davetcim/src/user_reservations/update/user_reservation_update_calendar_view.dart';
import 'package:davetcim/src/user_reservations/user_reservations_view.dart';
import 'package:davetcim/src/user_reservations/user_reservations_view_model.dart';
import 'package:davetcim/src/user_reservations/user_reservations_with_app_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared/dto/basket_user_dto.dart';
import '../../../shared/dto/reservation_detail_view_dto.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/dialogs.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_corporate_detail_services_summary.dart';
import '../../shared/models/corporation_package_services_model.dart';
import '../../widgets/grid_corporate_detail_package_summary.dart';
import '../../widgets/grid_service_package_summary_item.dart';
import '../notifications/notifications_view.dart';

class UserResevationDetailScreen extends StatefulWidget {
  @override
  _UserResevationDetailScreenState createState() => _UserResevationDetailScreenState();
  final ReservationModel reservationModel;
  final bool isFromNotification;

  UserResevationDetailScreen(
      {Key key,
        @required this.reservationModel,
        @required this.isFromNotification,
      })
      : super(key: key);

}

class _UserResevationDetailScreenState extends State<UserResevationDetailScreen>
    with AutomaticKeepAliveClientMixin<UserResevationDetailScreen> {

  ReservationDetailViewDto detailResponse = ReservationDetailViewDto();
  bool hasDataTaken = false;


  void getReservationDetail() async{
    UserReservationsViewModel rcm = UserReservationsViewModel();
    detailResponse = await rcm.getReservationDetail(widget.reservationModel);

    setState(() {
      detailResponse = detailResponse;
      hasDataTaken = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getReservationDetail();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!hasDataTaken) {
      return Scaffold(appBar:
        AppBarMenu(pageName: "Rezervasyon Detayı", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Center(child: CircularProgressIndicator())));
    }

    String addressRemaining = detailResponse.corporateModel.address;
    String createdAddress = "";
    while (addressRemaining.length > 30) {
      String addedAddress = addressRemaining.substring(0, 30);
      addressRemaining = addressRemaining.substring(30);
      createdAddress =  createdAddress + addedAddress + "\n\n";
    }
    if (addressRemaining.length > 0) {
      createdAddress =  createdAddress + addressRemaining + "\n\n";
    }

    Color color = Colors.green;
    String textStr = 'ONAYLANMIŞ REZERVASYON';
    if (detailResponse.reservationModel.reservationStatus == ReservationStatusEnum.adminRejected) {
      color = Colors.redAccent;
      textStr = 'RED EDİLMİŞ REZERVASYON';
    }
    else if(detailResponse.reservationModel.reservationStatus == ReservationStatusEnum.newRecord){
      color = Colors.grey;
      textStr = 'ONAY BEKLEYEN REZERVASYON';
    }

    bool isFromNotification = false;
    if (widget.isFromNotification != null) {
      isFromNotification = widget.isFromNotification;
    }

    return Scaffold(
      appBar: AppBarMenu(pageName: "Rezervasyon Detayı", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            //Müştreri
            SizedBox(height: 10.0),
            Container(
              height: MediaQuery.of(context).size.height / 13,
              child: Card(
                color: color,
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
                      fit: BoxFit.scaleDown,
                      child: Text(
                          textStr, style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
            //Müştreri
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
                        " FİRMA BİLGİLERİ", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
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
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                            detailResponse.corporateModel.corporationName
                                +"\n\nGsm No : "+detailResponse.corporateModel.telephoneNo
                                +"\n\nAdres : "+createdAddress,
                            style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

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
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                            "Tarih : "+DateConversionUtils.getDateTimeFromIntDate(detailResponse.reservationModel.date).toString().substring(0,10)
                                +"\n\nSeans : "+detailResponse.reservationModel.sessionName,
                            style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                        ),
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
                                    detailResponse.reservationModel.sessionName,
                                    "Organizasyon tarihi : "+DateConversionUtils.getDateTimeFromIntDate(detailResponse.reservationModel.date).toString().substring(0,10)
                                        +"\n\nSeans : "+ detailResponse.reservationModel.sessionName
                                        +"\n\nBu tarih için alınan hizmetler hariç salon kullanımı için ödenecek seans ücreti : "+ detailResponse.reservationModel.sessionCost.toString()+ "TL",
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          "Davetli Sayısı :" + detailResponse.reservationModel.invitationCount.toString()
                           +"\n\nDavet türü : "+ detailResponse.reservationModel.invitationType
                           +"\n\nOturma düzeni : "+ detailResponse.reservationModel.seatingArrangement,
                          style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                      ),
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
            ),

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
                        "PAKET SEÇİMİ", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
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
              itemCount: detailResponse.packageModel == null
                  ? 0 : 1,
              itemBuilder: (BuildContext context, int index) {
                CorporationPackageServicesModel item = detailResponse.packageModel;
                return GridCorporateDetailPackageSummary(packageModel: item,  detailModel: detailResponse);
              },
            ),

            //paketler
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
                        "HİZMET SEÇİMİ", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
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
              itemCount: detailResponse.detailList == null
                  ? 0
                  : detailResponse.detailList.length,
              itemBuilder: (BuildContext context, int index) {
                ReservationDetailModel item = detailResponse.detailList[index];

                return GridCorporateDetailServicesSummary(detailRowModel: item, detailModel: detailResponse);
              },
            ),
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
                        "Toplam Tutar", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                    SizedBox(width: MediaQuery.of(context).size.width /4),
                    Text(
                        detailResponse.reservationModel.cost.toString() +" TL ", style: TextStyle(fontSize: 20, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 5,),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: detailResponse.reservationModel.reservationStatus == ReservationStatusEnum.newRecord,
        child: Container(
          height: MediaQuery.of(context).size.height / 13,
          child: Card(
            color: Colors.white54,
            shadowColor: Colors.black,
            elevation: 10,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 15,
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.green,),
                        child: Text(
                          "GÜNCELLE".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          Utils.navigateToPage(context, UserReservationUpdateCalendarScreen(detailResponse: detailResponse));
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 15,
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.redAccent,),
                        child: Text(
                          "İPTAL".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          UserReservationsViewModel rcm = UserReservationsViewModel();
                          await rcm.rejectReservationForUser(detailResponse.reservationModel);
                          if (isFromNotification) {
                            Utils.navigateToPage(context, NotificationsView());
                          } else {
                            Utils.navigateToPage(context, UserReservationsWithAppBarScreen());
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
