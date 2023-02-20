import 'package:davetcim/shared/enums/reservation_status_enum.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/src/select-orders/summary_basket/summary_basket_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared/dto/basket_user_model.dart';
import '../../../shared/dto/reservation_detail_view_model.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/sessions/user_basket_session.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/dialogs.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_corporate_detail_services_summary.dart';
import '../../../widgets/grid_corporate_service_pool_for_basket.dart';
import '../../../widgets/grid_corporate_service_pool_for_basket_summary.dart';
import '../../admin_corporate_panel/service/service-corporate_view_model.dart';
import '../../notifications/notifications_view_model.dart';

class AllReservationCorporateDetailScreen extends StatefulWidget {
  @override
  _AllReservationCorporateDetailScreenState createState() => _AllReservationCorporateDetailScreenState();
  final ReservationModel reservationModel;

  AllReservationCorporateDetailScreen(
      {Key key,
        @required this.reservationModel,
      })
      : super(key: key);

}

class _AllReservationCorporateDetailScreenState extends State<AllReservationCorporateDetailScreen>
    with AutomaticKeepAliveClientMixin<AllReservationCorporateDetailScreen> {

  ReservationDetailViewModel detailResponse = ReservationDetailViewModel();


  void getReservationDetail() async{
    ReservationCorporateViewModel rcm = ReservationCorporateViewModel();
    detailResponse = await rcm.getReservationDetail(widget.reservationModel);

    setState(() {
      detailResponse = detailResponse;
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
    if (detailResponse == null || detailResponse.reservationModel == null) {
      return Scaffold(appBar:
        AppBarMenu(pageName: "Rezervasyon Detayı", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Center(child: CircularProgressIndicator())));
    }

    Color color = Colors.green;
    String textStr = 'ONAYLANMIŞ REZERVASYON';
    if (detailResponse.reservationModel.reservationStatus == ReservationStatusEnum.adminRejected) {
      color = Colors.redAccent;
      textStr = 'RED EDİLMİŞ REZERVASYON';
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
                    Text(
                        textStr, style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
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
                        " MÜŞTERİ BİLGİLERİ", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
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
                          detailResponse.customerModel.name + " " + detailResponse.customerModel.surname
                              +"\n\nGsm No : "+detailResponse.customerModel.gsmNo
                              +"\n\nemail : "+detailResponse.customerModel.eMail,
                          style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
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
                      Text(
                          "Tarih : "+DateConversionUtils.getDateTimeFromIntDate(detailResponse.reservationModel.date).toString().substring(0,10)
                              +"\n\nSeans : "+detailResponse.sessionModel.name,
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
                                    detailResponse.sessionModel.name,
                                    "Organizasyon tarihi : "+DateConversionUtils.getDateTimeFromIntDate(detailResponse.reservationModel.date).toString().substring(0,10)
                                        +"\n\nSeans : "+ detailResponse.sessionModel.name
                                        +"\n\nBu tarih için alınan hizmetler hariç salon kullanımı için ödenecek seans ücreti : "+ detailResponse.reservationModel.cost.toString()+ "TL",
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
                    Text(
                        "Davetli Sayısı :" + detailResponse.reservationModel.invitationCount.toString()
                         +"\n\nDavet türü : "+ detailResponse.reservationModel.invitationType
                         +"\n\nOturma düzeni : "+ detailResponse.reservationModel.seatingArrangement,
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
