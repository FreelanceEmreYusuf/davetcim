import 'package:davetcim/shared/enums/reservation_status_enum.dart';
import 'package:davetcim/shared/sessions/reservation_edit_state.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import 'package:davetcim/widgets/expanded_card_widget.dart';
import 'package:flutter/material.dart';
import '../../../shared/dto/reservation_detail_view_dto.dart';
import '../../../shared/enums/corporation_event_log_enum.dart';
import '../../../shared/enums/dialog_input_validator_type_enum.dart';
import '../../../shared/environments/const.dart';
import '../../../shared/helpers/general_helper.dart';
import '../../../shared/helpers/pdf_helper.dart';
import '../../../shared/helpers/reservation_helper.dart';
import '../../../shared/models/corporation_package_services_model.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/dialogs.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/communication_card_panel.dart';
import '../../../widgets/grid_corporate_detail_package_summary.dart';
import '../../../widgets/grid_corporate_detail_services_summary.dart';
import '../../../widgets/indicator.dart';
import '../../notifications/notifications_view.dart';
import '../../notifications/notifications_view_model.dart';
import '../../user_reservations/user_reservations_view_model.dart';
import '../all_reservation/all_reservation_corporate_delay_date_view.dart';
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



  Future<bool> reservationControl() async {
    ReservationHelper reservationHelper = ReservationHelper();
    ReservationModel currentResModel = await reservationHelper.getReservation(widget.reservationModel.id);
    if (currentResModel.userReservationVersion != widget.reservationModel.userReservationVersion) {
      Dialogs.showInfoModalContent(context, "Üzgünüz", "Bu teklif, kullanıcı tarafından güncellendi. Güncel rezervasyonu görmek için tamam button'una basınız",
          navigateToReservationsPage);
      return false;
    }

    List<ReservationModel> reservationList =
    await reservationHelper.getReservationListBySessionIdAndDateForApproveControl(
        widget.reservationModel.sessionId, widget.reservationModel.date);
    for (int i = 0; i < reservationList.length; i++)  {
      ReservationModel reservationRowModel = reservationList[i];
      if (reservationRowModel.id != widget.reservationModel.id &&
          reservationRowModel.reservationStatus != ReservationStatusEnum.userOffer) {
        Dialogs.showInfoModalContent(context, "Üzgünüz",
            "Bu seans; bir başkası için opsiyonlanmış ya da satış işlemi yapılmıştır.",
            navigateToReservationsPage);
        return false;
      }
    }
    return true;
  }

  void approveReservation(bool isFromNotification) async {
    if (await reservationControl()) {
      ReservationCorporateViewModel rcm = ReservationCorporateViewModel();
      NotificationsViewModel notificationViewModel = NotificationsViewModel();
      await rcm.editReservationForAdmin(detailResponse.reservationModel, true);
      notificationViewModel.sendNotificationToUser(context, widget.reservationModel.corporationId,
          widget.reservationModel.customerId,
          0, widget.reservationModel.id,
          widget.reservationModel.reservationStatus.index,
          true, widget.reservationModel.description, "");
      notificationViewModel.deleteNotificationsFromAdminUsers(context, 0, widget.reservationModel.id);

      CorporationAnalysisViewModel corporationAnalysisViewModel = CorporationAnalysisViewModel();
      corporationAnalysisViewModel.editDailyLog(widget.reservationModel.corporationId,
          CorporationEventLogEnum.newReservation.name, detailResponse.reservationModel.cost);

      navigateToCallerPage(context);
    }
  }

  void approveReservationForSell(int newCost) async {
    if (await reservationControl()) {
      ReservationCorporateViewModel rcm = ReservationCorporateViewModel();
      NotificationsViewModel notificationViewModel = NotificationsViewModel();
      if (newCost != null && newCost > 0) {
        detailResponse.reservationModel.cost = newCost;
      }

      await rcm.editReservationForAdmin(detailResponse.reservationModel, true);
      notificationViewModel.sendNotificationToUser(context, widget.reservationModel.corporationId,
          widget.reservationModel.customerId,
          0, widget.reservationModel.id,
          widget.reservationModel.reservationStatus.index,
          true, widget.reservationModel.description, "");
      notificationViewModel.deleteNotificationsFromAdminUsers(context, 0, widget.reservationModel.id);

      CorporationAnalysisViewModel corporationAnalysisViewModel = CorporationAnalysisViewModel();
      corporationAnalysisViewModel.editDailyLog(widget.reservationModel.corporationId,
          CorporationEventLogEnum.newReservation.name, detailResponse.reservationModel.cost);

      navigateToCallerPage(context);
    }
  }

  void rejectReservation(bool isFromNotification) async {
    ReservationCorporateViewModel rcm = ReservationCorporateViewModel();
    NotificationsViewModel notificationViewModel = NotificationsViewModel();
    await rcm.editReservationForAdmin(detailResponse.reservationModel, false);
    notificationViewModel.sendNotificationToUser(context, widget.reservationModel.corporationId,
        widget.reservationModel.customerId,
        0, widget.reservationModel.id,
        widget.reservationModel.reservationStatus.index,
        false, widget.reservationModel.description, "");
    notificationViewModel.deleteNotificationsFromAdminUsers(context, 0, widget.reservationModel.id);
    navigateToCallerPage(context);
  }

  void navigateToViewPage(BuildContext context) {
    Utils.navigateToPage(context, ReservationCorporateView());
  }

  void navigateToCallerPage(BuildContext context) {
    Utils.navigateToCallerPage(context);
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

    String buttonApproveText = "Teklifi Opsiyonla";
    String buttonRejectText = "Teklifi Reddet";

    Color color = Colors.green;
    String textStr = 'ONAYLANMIŞ REZERVASYON';
    String pdfButtonText = "TEKLİF İÇİN PDF GÖSTER";
    bool isPDFButtonVisible = true;

    if (widget.reservationModel.reservationStatus == ReservationStatusEnum.preReservation) {
      buttonApproveText = "Satış";
      buttonRejectText = "Teklife Çevir";
    }

    if (detailResponse.reservationModel.reservationStatus == ReservationStatusEnum.userOffer) {
      color = Colors.blueGrey;
      textStr = 'GELEN TEKLİF';
    } else if (detailResponse.reservationModel.reservationStatus == ReservationStatusEnum.adminRejectedOffer) {
      color = Colors.redAccent;
      textStr = 'RED EDİLMİŞ TEKLİF';
      isPDFButtonVisible = false;
    } else if (detailResponse.reservationModel.reservationStatus == ReservationStatusEnum.userRejectedOffer) {
      color = Colors.redAccent;
      textStr = 'RED EDİLMİŞ TEKLİF';
      isPDFButtonVisible = false;
    } else if (detailResponse.reservationModel.reservationStatus == ReservationStatusEnum.preReservation) {
      color = Colors.blueAccent;
      textStr = 'OPSİYONLANMIŞ';
    } else if (detailResponse.reservationModel.reservationStatus == ReservationStatusEnum.reservation) {
      color = Colors.redAccent;
      textStr = 'SATIŞ';
      pdfButtonText = "SATIŞ İÇİN PDF GÖSTER";
    }

    return Scaffold(
      appBar: AppBarMenu(pageName: "Rezervasyon Detayı", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
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
            SizedBox(height: 10.0),
            Visibility(
              visible: isPDFButtonVisible,
              child: ElevatedButton(
                onPressed: ()  {
                  PDFHelper pdfHelper = PDFHelper();
                  if (detailResponse.reservationModel.reservationStatus == ReservationStatusEnum.reservation) {
                    pdfHelper.createAndShowReservationPDFFromReservationDetail(context, detailResponse);
                  } else {
                    pdfHelper.createAndShowOfferPDFFromReservationDetail(context, detailResponse);
                  }
                },
                child: Text(
                  pdfButtonText.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                        " MÜŞTERİ BİLGİLERİ", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                  ],
                ),
              ),
            ),
            ExpandableCard(expandedContent: CommunicationCardPanel(detailResponse.customerModel.gsmNo,detailResponse.customerModel.eMail), collapsedContent: Text(
                "Müşteri Adı: "+detailResponse.customerModel.name + " " + detailResponse.customerModel.surname
                    +"\n\nMüşteriyle iletişime geçmek için dokunun.",
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
            ExpandableCard(expandedContent: Text("Organizasyon Tarihi : "+DateConversionUtils.intDateToString(detailResponse.reservationModel.date)
                +"\n\nSeans : "+ detailResponse.reservationModel.sessionName
                +"\n\nKayıt Tarihi : "+ DateConversionUtils.timestampToString(detailResponse.reservationModel.recordDate)
                +"\n\nBu seans için alınan hizmetler hariç salon kullanımı için ödenecek ücret : "+ GeneralHelper.formatMoney(detailResponse.reservationModel.sessionCost.toString())+ "TL",), collapsedContent: Text(
                "Organizasyon Tarihi : "+DateConversionUtils.intDateToString(detailResponse.reservationModel.date)
                    +"\n\nSeans bilgisi için dokunun",
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
                      style: TextButton.styleFrom(backgroundColor: Colors.deepOrangeAccent,),
                      child: Text(
                        "Ertele",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        ReservationHelper reservationHelper = ReservationHelper();
                        if (await reservationHelper.isReservationVersionChanged(
                            widget.reservationModel.id, widget.reservationModel.version)) {
                          Dialogs.showInfoModalContent(
                              context,
                              "Uyarı",
                              "Bu işlemde değişiklik yapıldı.Sayfayı tekrar yüklemelisiniz.",
                              navigateToViewPage);
                        } else {
                          Utils.navigateToPage(context,
                              AllReservationCorporateDelayDateScreen(reservationModel: widget.reservationModel,));
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
                      style: TextButton.styleFrom(backgroundColor: Colors.green,),
                      child: Text(
                        buttonApproveText,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        ReservationHelper reservationHelper = ReservationHelper();
                        if (await reservationHelper.isReservationVersionChanged(
                            widget.reservationModel.id, widget.reservationModel.version)) {
                          Dialogs.showInfoModalContent(
                              context,
                              "Uyarı",
                              "Bu işlemde değişiklik yapıldı.Sayfayı tekrar yüklemelisiniz.",
                              navigateToViewPage);
                        } else {
                          if (detailResponse.reservationModel.reservationStatus ==
                              ReservationStatusEnum.preReservation) {
                            Dialogs.showDialogModalContentWithInputBoxForOffer(context,detailResponse.reservationModel.cost.toString(),
                                "Satış", Constants.reservationDiscountMessage, "İptal", "Satış", "Son Teklif Tutarı", 1,
                                approveReservationForSell, DailogInmputValidatorTypeEnum.jutNumber, lineCount: 1);
                          } else {
                            approveReservation(isFromNotification);
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
                        buttonRejectText,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        ReservationHelper reservationHelper = ReservationHelper();
                        if (await reservationHelper.isReservationVersionChanged(
                            widget.reservationModel.id, widget.reservationModel.version)) {
                          Dialogs.showInfoModalContent(
                              context,
                              "Uyarı",
                              "Bu işlemde değişiklik yapıldı.Sayfayı tekrar yüklemelisiniz.",
                              navigateToViewPage);
                        } else {
                          rejectReservation(isFromNotification);
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
