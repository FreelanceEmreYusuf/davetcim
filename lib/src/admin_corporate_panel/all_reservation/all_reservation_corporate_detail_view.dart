import 'package:davetcim/shared/enums/reservation_status_enum.dart';
import 'package:davetcim/shared/sessions/reservation_edit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/dto/reservation_detail_view_dto.dart';
import '../../../shared/helpers/general_helper.dart';
import '../../../shared/models/corporation_package_services_model.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/dialogs.dart';
import '../../../shared/utils/language.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_corporate_detail_package_summary.dart';
import '../../../widgets/grid_corporate_detail_services_summary.dart';
import '../../../widgets/indicator.dart';
import '../../notifications/notifications_view_model.dart';
import '../../user_reservations/user_reservations_view_model.dart';
import '../reservation/reservation_corporate_view_model.dart';
import 'all_reservation_corporate_delay_date_view.dart';
import 'all_reservation_corporate_landing_view.dart';

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

  void rejectReservation() async {
    ReservationCorporateViewModel rcm = ReservationCorporateViewModel();
    NotificationsViewModel notificationViewModel = NotificationsViewModel();
    await rcm.editReservationForAdmin(detailResponse.reservationModel, false);
    notificationViewModel.sendNotificationToUser(context, widget.reservationModel.corporationId,
        widget.reservationModel.customerId,
        0, widget.reservationModel.id, false, widget.reservationModel.description, "");
    Utils.navigateToPage(context, AllReservationLandingView(pageIndex: 1));
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!hasDataTaken) {
      return Scaffold(appBar:
        AppBarMenu(pageName: "Rezervasyon Detayı", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Center(child: Indicator())));
    }

    bool isAvailableForDelayOrCancel = false;
    if (detailResponse.reservationModel.reservationStatus == ReservationStatusEnum.approved &&
        detailResponse.reservationModel.date >= DateConversionUtils.getTodayAsInt()) {
      isAvailableForDelayOrCancel = true;
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
                      fit: BoxFit.scaleDown,
                      child: Text(
                          " MÜŞTERİ BİLGİLERİ", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                Clipboard.setData(ClipboardData(text: detailResponse.customerModel.gsmNo)).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: FittedBox(child: Text("Telefon numarası panoya kopyalandı("+detailResponse.customerModel.gsmNo+")")), duration: Duration(seconds: 1),));
                });
              },
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: SingleChildScrollView(
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
                                detailResponse.customerModel.name + " " + detailResponse.customerModel.surname
                                    +"\n\nGsm No : "+detailResponse.customerModel.gsmNo
                                    +"\n\nemail : "+detailResponse.customerModel.eMail,
                                style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          " TARİH & SEANS", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: SingleChildScrollView(
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
                                  Dialogs.showInfoModalContent(
                                      context,
                                      detailResponse.reservationModel.sessionName,
                                      "Organizasyon tarihi : "+DateConversionUtils.getDateTimeFromIntDate(detailResponse.reservationModel.date).toString().substring(0,10)
                                          +"\n\nSeans : "+ detailResponse.reservationModel.sessionName
                                          +"\n\nBu tarih için alınan hizmetler hariç salon kullanımı için ödenecek seans ücreti : "+ GeneralHelper.formatMoney(detailResponse.reservationModel.sessionCost.toString())+ "TL",
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
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
                              Dialogs.showInfoModalContent(
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          "PAKET SEÇİMİ", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                    ),
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
                ReservationEditState.reservationDetail = detailResponse;
                CorporationPackageServicesModel item = detailResponse.packageModel;
                return GridCorporateDetailPackageSummary(packageModel: item);
              },
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          "HİZMETLER", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                    ),
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
                ReservationEditState.reservationDetail = detailResponse;
                ReservationDetailModel item = detailResponse.detailList[index];
                return GridCorporateDetailServicesSummary(detailRowModel: item);
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          "Toplam Tutar", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                    ),
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
        visible: isAvailableForDelayOrCancel,
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
                          "ERTELE".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          Utils.navigateToPage(context,
                              AllReservationCorporateDelayDateScreen(reservationModel: widget.reservationModel,));
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
                          "REDDET".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          await Dialogs.showDialogMessage(
                              context,
                              LanguageConstants
                                  .processApproveHeader[LanguageConstants.languageFlag],
                              "Daha önceden onaylanmış olan rezervasyonu, iptal etmek istediğinize emin misiniz?",
                              rejectReservation, '');
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
