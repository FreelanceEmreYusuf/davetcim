import 'package:davetcim/shared/sessions/reservation_edit_state.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import 'package:davetcim/widgets/expanded_card_widget.dart';
import 'package:flutter/material.dart';
import '../../../shared/dto/reservation_detail_view_dto.dart';
import '../../../shared/enums/corporation_event_log_enum.dart';
import '../../../shared/helpers/general_helper.dart';
import '../../../shared/helpers/reservation_helper.dart';
import '../../../shared/models/corporation_package_services_model.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/dialogs.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_corporate_detail_package_summary.dart';
import '../../../widgets/grid_corporate_detail_services_summary.dart';
import '../../../widgets/indicator.dart';
import '../../notifications/notifications_view.dart';
import '../../notifications/notifications_view_model.dart';
import '../../user_reservations/user_reservations_view_model.dart';
import '../corporation_analysis/corporation_analysis_view_model.dart';

class ReservationCorporateDetailScreen extends StatefulWidget {
  @override
  _ReservationCorporateDetailScreenState createState() => _ReservationCorporateDetailScreenState();
  final ReservationModel reservationModel;
  final bool isFromNotification;

  ReservationCorporateDetailScreen(
      {Key key,
        @required this.reservationModel,
        @required this.isFromNotification,
      })
      : super(key: key);

}

class _ReservationCorporateDetailScreenState extends State<ReservationCorporateDetailScreen>
    with AutomaticKeepAliveClientMixin<ReservationCorporateDetailScreen> {

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

  void navigateToReservationsPage(BuildContext context) {
    Utils.navigateToPage(context, ReservationCorporateView());
  }



  Future<bool> hasReservationChangedByUser() async {
    ReservationHelper reservationHelper = ReservationHelper();
    ReservationModel currentResModel = await reservationHelper.getReservation(widget.reservationModel.id);
    if (currentResModel.userReservationVersion != widget.reservationModel.userReservationVersion) {
      return true;
    }
    return false;
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
            ExpandableCard(expandedContent: Text("Rezervasyon talebinde bulunan müşteriyle iletişim kurabilmeniz için gerekli iletişim bilgilerini içerir"), collapsedContent: Text(
                detailResponse.customerModel.name + " " + detailResponse.customerModel.surname
                    +"\n\nGsm No : "+detailResponse.customerModel.gsmNo
                    +"\n\nemail : "+detailResponse.customerModel.eMail,
                style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
            ),),
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
            ExpandableCard(expandedContent: Text("Organizasyon tarihi : "+DateConversionUtils.getDateTimeFromIntDate(detailResponse.reservationModel.date).toString().substring(0,10)
                +"\n\nSeans : "+ detailResponse.reservationModel.sessionName
                +"\n\nBu seans için alınan hizmetler hariç salon kullanımı için ödenecek ücret : "+ GeneralHelper.formatMoney(detailResponse.reservationModel.sessionCost.toString())+ "TL",), collapsedContent: Text(
                "Tarih : "+DateConversionUtils.getDateTimeFromIntDate(detailResponse.reservationModel.date).toString().substring(0,10)
                    +"\n\nSeans bilgisi için detayı inceleyin",
                style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
            ),),
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
                        "ORGANİZASYON DETAYLARI", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                  ],
                ),
              ),
            ),
            ExpandableCard(expandedContent: Text("Organizsayon ücretini oluşturan birçok hizmet kalemi, davetli sayısına bağlı olarak artabilmektedir.",), collapsedContent: Text(
                "Davetli Sayısı :" + detailResponse.reservationModel.invitationCount.toString()
                    +"\n\nDavet türü : "+ detailResponse.reservationModel.invitationType
                    +"\n\nOturma düzeni : "+ detailResponse.reservationModel.seatingArrangement,
                style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
            ),),

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
                child:  Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                            "Toplam Tutar", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                      ),
                      Expanded(
                        child: Text(
                            GeneralHelper.formatMoney(detailResponse.reservationModel.cost.toString())  +" TL ", style: TextStyle(fontSize: 20, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 5,),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.height / 10,
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
            padding: const EdgeInsets.all(3.0),
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
                        "ONAYLA".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (await hasReservationChangedByUser()) {
                          Dialogs.showInfoModalContent(context, "Üzgünüz", "Bu rezervasyon, kullanıcı tarafından güncellendi. Güncel rezervasyonu görmek için tamam button'una basınız",
                              navigateToReservationsPage);
                        } else {
                          ReservationCorporateViewModel rcm = ReservationCorporateViewModel();
                          NotificationsViewModel notificationViewModel = NotificationsViewModel();
                          await rcm.editReservationForAdmin(detailResponse.reservationModel, true);
                          notificationViewModel.sendNotificationToUser(context, widget.reservationModel.corporationId,
                              widget.reservationModel.customerId,
                              0, widget.reservationModel.id, true, widget.reservationModel.description, "");
                          notificationViewModel.deleteNotificationsFromAdminUsers(context, 0, widget.reservationModel.id);

                          CorporationAnalysisViewModel corporationAnalysisViewModel = CorporationAnalysisViewModel();
                          corporationAnalysisViewModel.editDailyLog(widget.reservationModel.corporationId,
                              CorporationEventLogEnum.newReservation.name, detailResponse.reservationModel.cost);

                          if (isFromNotification) {
                            Utils.navigateToPage(context, NotificationsView());
                          } else {
                            Utils.navigateToPage(context, ReservationCorporateView());
                          }
                        }
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
                        if (await hasReservationChangedByUser()) {
                          Dialogs.showInfoModalContent(context, "Üzgünüz", "Bu rezervasyon, kullanıcı tarafından güncellendi. Güncel rezervasyonu görmek için tamam button'una basınız",
                              navigateToReservationsPage);
                        } else {
                          ReservationCorporateViewModel rcm = ReservationCorporateViewModel();
                          NotificationsViewModel notificationViewModel = NotificationsViewModel();
                          await rcm.editReservationForAdmin(detailResponse.reservationModel, false);
                          notificationViewModel.sendNotificationToUser(context, widget.reservationModel.corporationId,
                              widget.reservationModel.customerId,
                              0, widget.reservationModel.id, false, widget.reservationModel.description, "");
                          notificationViewModel.deleteNotificationsFromAdminUsers(context, 0, widget.reservationModel.id);
                          if (isFromNotification) {
                            Utils.navigateToPage(context, NotificationsView());
                          } else {
                            Utils.navigateToPage(context, ReservationCorporateView());
                          }
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
