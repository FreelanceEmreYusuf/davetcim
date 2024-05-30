import 'dart:io';
import 'dart:typed_data';
import 'package:davetcim/shared/models/service_pool_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../src/admin_corporate_panel/corporation_contract_management/corporate_contract_management_view_model.dart';
import '../../src/products/product_detail_view_model.dart';
import '../dto/reservation_detail_view_dto.dart';
import '../models/corporation_main_contract_model.dart';
import '../models/reservation_detail_model.dart';
import '../sessions/user_basket_state.dart';
import '../sessions/user_state.dart';
import '../utils/date_utils.dart';

class PDFHelper {

  Future<pw.Font> loadCustomFont(String fontAssetPath) async {
    final ByteData fontData = await rootBundle.load(fontAssetPath);
    final Uint8List fontBytes = fontData.buffer.asUint8List();
    return pw.Font.ttf(fontBytes.buffer.asByteData());
  }

  pw.Widget addChildColumn(
      String text,
      pw.TextAlign textAlign,
      pw.Font font,
      bool isBold,
      {double spacing = 10.0}
      ) {

    pw.TextStyle textStyle = pw.TextStyle(
      fontSize: 10,
      font: font,
      color: PdfColor.fromInt(0xff000000),
      lineSpacing: 5,
    );

    if (isBold) {
      textStyle = textStyle.copyWith(
        fontWeight: pw.FontWeight.bold,
      );
    }

    pw.Text textWidget = pw.Text(
      text,
      textAlign: textAlign,
      style: textStyle,
    );

    return pw.Container(
      padding: pw.EdgeInsets.only(bottom: spacing),
      child: textWidget,
    );
  }

  pw.Widget addChildColumnForExtraContract(
      String text,
      pw.TextAlign textAlign,
      pw.Font font,
      bool isBold,
      {double spacing = 10.0, lineSpacing = 6.0}
      ) {

    pw.TextStyle textStyle = pw.TextStyle(
      fontSize: 10,
      font: font,
      color: PdfColor.fromInt(0xff000000),
      lineSpacing: lineSpacing,
    );

    if (isBold) {
      textStyle = textStyle.copyWith(
        fontWeight: pw.FontWeight.bold,
      );
    }

    pw.Text textWidget = pw.Text(
      text,
      textAlign: textAlign,
      style: textStyle,
    );

    return pw.Container(
      padding: pw.EdgeInsets.only(bottom: spacing),
      child: textWidget,
    );
  }

  pw.Widget getServicesList(pw.Font font) {
    List<pw.Widget> widgetList = [];

    if (UserBasketState.userBasket.servicePoolModel == null) {
      return pw.Container(
        height: 20.0,
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: widgetList,
        ),
      );
    }

    if (UserBasketState.userBasket.servicePoolModel != null) {
      String services ="";
      for (int i = 0; i < UserBasketState.userBasket.servicePoolModel.length; i++) {
        ServicePoolModel servicePoolModel = UserBasketState.userBasket.servicePoolModel[i];
        if (!servicePoolModel.hasChild && servicePoolModel.companyHasService) {
          if(services.isEmpty)
          services = servicePoolModel.serviceName.replaceAll("-", "") + " ";
          else
            services = services + "," + servicePoolModel.serviceName.replaceAll("-", "") + " ";
        }
      }
      widgetList.add(
            addChildColumn(
              services,
              pw.TextAlign.left,
              font,
              false,
            ),
          );
    }

    return pw.Container(
      height: UserBasketState.userBasket.servicePoolModel.length * 20.0,
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: widgetList,
      ),
    );
  }



  pw.Widget getMainContractList(pw.Font font, List<CorporationMainContractModel> contractList) {
    List<pw.Widget> widgetList = [];
    for (int i = 0; i < contractList.length; i++) {
      CorporationMainContractModel contractModel = contractList[i];
      widgetList.add(
        addChildColumn(
          contractModel.contractRow,
          pw.TextAlign.left,
          font,
          false,
        ),
      );
    }

    return pw.Container(
      height: contractList.length * 20.0,
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: widgetList,
      ),
    );
  }


  Future<void> createAndShowOfferPDF(BuildContext context) async {
    final pdf = pw.Document();
    pw.Font latoFont = await loadCustomFont('assets/fonts/Lato-Black.ttf');
    ProductsViewDetailModel productsViewDetailModel = ProductsViewDetailModel();
    String districtName = await productsViewDetailModel.getDistrict(int.parse(UserBasketState.userBasket.corporationModel.district));
    String packageTitle = "";
    String packageBody = "";
    CorporateContractManagementViewModel contractManagementViewModel = CorporateContractManagementViewModel();
    List<CorporationMainContractModel> contractList = await contractManagementViewModel.getMainContractList(false);

    if (UserBasketState.userBasket.packageModel != null) {
      packageTitle = UserBasketState.userBasket.packageModel.title;
      packageBody = UserBasketState.userBasket.packageModel.body;
    }

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        addChildColumn('Referans Kodu ' +
                            new DateTime.now().millisecondsSinceEpoch.toString(),
                            pw.TextAlign.left, latoFont, false),
                    ],),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        addChildColumn('İşlem Tarihi: ' +
                            DateConversionUtils.getCurrentViewTime(),
                            pw.TextAlign.right, latoFont, false),
                        addChildColumn(UserBasketState.userBasket.corporationModel.address,
                            pw.TextAlign.right, latoFont, false),
                        addChildColumn(districtName,
                            pw.TextAlign.right, latoFont, false),
                        addChildColumn(UserBasketState.userBasket.corporationModel.email,
                            pw.TextAlign.right, latoFont, false),
                        pw.SizedBox(height: 20),
                      ],),
                  ),
            ]),
            pw.SizedBox(height: 20),
            addChildColumn(UserBasketState.userBasket.corporationModel.corporationName.toUpperCase() + " TEKLİF",
                pw.TextAlign.center, latoFont, true),
            addChildColumn("BU TEKLİF 10 GÜN İÇİN GEÇERLİDİR. SÖZLEŞME YERİNE GEÇMEZ",
                pw.TextAlign.center, latoFont, true),
            pw.SizedBox(height: 20),

            pw.Center(child:
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      addChildColumn(
                        "MÜŞTERİ BİLGİLERİ",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      addChildColumn(
                        "İsim :" + UserState.name,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Soyisim :" + UserState.surname,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Cep Telefonu :" + UserState.gsmNo,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
                pw.SizedBox(width: 20),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      addChildColumn(
                        "ETKİNLİK BİLGİLERİ",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      addChildColumn(
                        "Etkinlik Tarihi :" +
                            DateConversionUtils.getCurrentViewTimeFromInt(
                              UserBasketState.userBasket.date,
                            ),
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Etkinlik Saati :" +
                            UserBasketState.userBasket.sessionModel.name,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Etkinlik Türü :" +
                            UserBasketState.userBasket.orderBasketModel.invitationType,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Oturma Düzeni :" +
                            UserBasketState.userBasket.orderBasketModel.sequenceOrder,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Garanti Kişi Sayısı :" +
                            UserBasketState.userBasket.orderBasketModel.count.toString(),
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Kişi Başı ÜCret : " +
                            (UserBasketState.userBasket.totalPrice / UserBasketState.userBasket.orderBasketModel.count).toStringAsFixed(2)+" TL",
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Paketin Adı :" + packageTitle,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            ),

            pw.SizedBox(width: 20),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  addChildColumn(
                    "ETKİNLİK ÖDEME TÜRÜ PLANLAMA",
                    pw.TextAlign.left,
                    latoFont,
                    true,
                  ),
                  addChildColumn(
                    "Ödeme Türü: Kaporalı",
                    pw.TextAlign.left,
                    latoFont,
                    false,
                  ),
                  addChildColumn(
                    "Toplam:" +
                        UserBasketState.userBasket.totalPrice.toString() +
                        " TL",
                    pw.TextAlign.left,
                    latoFont,
                    false,
                  ),
                  addChildColumn(
                    "Önemli: Tahsilat makbuzu almadan yapılan ödemeler geçersizdir.",
                    pw.TextAlign.left,
                    latoFont,
                    true,
                  ),
                ],
              ),
            ),
            addChildColumn(
              "MADDELER :",
              pw.TextAlign.left,
              latoFont,
              true,
            ),
            getMainContractList(latoFont, contractList),
            pw.SizedBox(height: 20),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.SizedBox(width: 20),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      addChildColumn("İLGİLİ PERSONEL",
                          pw.TextAlign.left, latoFont, true),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
                pw.SizedBox(width: 20),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      addChildColumn("MÜŞTERİ",
                          pw.TextAlign.right, latoFont, true),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(child:
            addChildColumn(
              "EK 1",
              pw.TextAlign.left,
              latoFont,
              true,
            ),),
            pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          addChildColumn(
                            "PAKET HARİCİ HİZMETLER",
                            pw.TextAlign.left,
                            latoFont,
                            true,
                          ),
                          pw.SizedBox(height: 10),
                          getServicesList(latoFont),
                          pw.SizedBox(height: 10),
                          addChildColumn(
                            "PAKET BİLGİLERİ",
                            pw.TextAlign.left,
                            latoFont,
                            true,
                          ),
                          pw.SizedBox(height: 10),
                          addChildColumn(
                            packageTitle,
                            pw.TextAlign.left,
                            latoFont,
                            true,
                          ),
                          pw.SizedBox(height: 10),
                          addChildColumn(
                            packageBody,
                            pw.TextAlign.left,
                            latoFont,
                            true,
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 20),
                  ],
                ),
          ],
      ),),
    );

    String fileName = "offer_" +
        new DateTime.now().millisecondsSinceEpoch.toString() + ".pdf";

    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final pdfFile = File('$tempPath/$fileName');
    await pdfFile.writeAsBytes(await pdf.save());

    OpenFile.open(pdfFile.path);
  }

  pw.Widget getServicesListFromReservationDetail(pw.Font font,
      ReservationDetailViewDto reservationDetail) {
    List<pw.Widget> widgetList = [];

    if (reservationDetail.detailList == null) {
      return pw.Container(
        height: 20.0,
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: widgetList,
        ),
      );
    }

    String services ="";
    for (int i = 0; i < reservationDetail.detailList.length; i++) {
      ReservationDetailModel detailRowModel = reservationDetail.detailList[i];
      if(services.isEmpty)
        services = detailRowModel.serviceName.replaceAll("-", "") + " ";
      else
        services = services + "," + detailRowModel.serviceName.replaceAll("-", "") + " ";
    }
    widgetList.add(
      addChildColumn(
        services,
        pw.TextAlign.left,
        font,
        false,
      ),
    );

    return pw.Container(
      height: reservationDetail.detailList.length * 20.0,
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: widgetList,
      ),
    );
  }

  Future<String> getExtraContract() async {
    List<pw.Widget> widgetList = [];

    CorporateContractManagementViewModel model = CorporateContractManagementViewModel();
    String contractBody = await model.getContract(UserState.corporationId);
    return contractBody;
  }




  Future<void> createAndShowOfferPDFFromReservationDetail(BuildContext context,
      ReservationDetailViewDto reservationDetail) async {
    final pdf = pw.Document();
    pw.Font latoFont = await loadCustomFont('assets/fonts/Lato-Black.ttf');
    ProductsViewDetailModel productsViewDetailModel = ProductsViewDetailModel();
    String districtName = await productsViewDetailModel.getDistrict(
        int.parse(reservationDetail.corporateModel.district));
    String packageTitle = "";
    String sessionName = "";
    String packageBody = "";
    if (reservationDetail.packageModel != null) {
      packageTitle = reservationDetail.packageModel.title;
      packageBody = reservationDetail.packageModel.body;
    }
    if (reservationDetail.selectedSessionModel != null) {
      sessionName = reservationDetail.selectedSessionModel.name;
    }

    CorporateContractManagementViewModel contractManagementViewModel = CorporateContractManagementViewModel();
    List<CorporationMainContractModel> contractList = await contractManagementViewModel.getMainContractList(false);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        addChildColumn('Referans Kodu ' +
                            new DateTime.now().millisecondsSinceEpoch.toString(),
                            pw.TextAlign.left, latoFont, false),
                      ],),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        addChildColumn('İşlem Tarihi: ' +
                            DateConversionUtils.getCurrentViewTime(),
                            pw.TextAlign.right, latoFont, false),
                        addChildColumn(reservationDetail.corporateModel.address,
                            pw.TextAlign.right, latoFont, false),
                        addChildColumn(districtName,
                            pw.TextAlign.right, latoFont, false),
                        addChildColumn(reservationDetail.corporateModel.email,
                            pw.TextAlign.right, latoFont, false),
                        pw.SizedBox(height: 20),
                      ],),
                  ),
                ]),
            pw.SizedBox(height: 20),
            addChildColumn(reservationDetail.corporateModel.corporationName.toUpperCase() + " TEKLİF",
                pw.TextAlign.center, latoFont, true),
            addChildColumn("BU TEKLİF 10 GÜN İÇİN GEÇERLİDİR. SÖZLEŞME YERİNE GEÇMEZ",
                pw.TextAlign.center, latoFont, true),
            pw.SizedBox(height: 20),

            pw.Center(child:
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      addChildColumn(
                        "MÜŞTERİ BİLGİLERİ",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      addChildColumn(
                        "İsim :" + reservationDetail.customerModel.name,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Soyisim :" + reservationDetail.customerModel.surname,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Cep Telefonu :" + reservationDetail.customerModel.gsmNo,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
                pw.SizedBox(width: 20),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      addChildColumn(
                        "ETKİNLİK BİLGİLERİ",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      addChildColumn(
                        "Etkinlik Tarihi :" +
                            DateConversionUtils.getCurrentViewTimeFromInt(
                              reservationDetail.reservationModel.date
                            ),
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Etkinlik Saati :" +
                            sessionName,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Etkinlik Türü :" +
                            reservationDetail.reservationModel.invitationType,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Oturma Düzeni :" +
                            reservationDetail.reservationModel.seatingArrangement,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Garanti Kişi Sayısı :" +
                            reservationDetail.reservationModel.invitationCount.toString(),
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Kişi Başı ÜCret : " +
                            (reservationDetail.reservationModel.cost /
                                reservationDetail.reservationModel.invitationCount).toStringAsFixed(2)+" TL",
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Paketin Adı :" + packageTitle,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            ),

            pw.SizedBox(width: 20),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  addChildColumn(
                    "ETKİNLİK ÖDEME TÜRÜ PLANLAMA",
                    pw.TextAlign.left,
                    latoFont,
                    true,
                  ),
                  addChildColumn(
                    "Ödeme Türü: Kaporalı",
                    pw.TextAlign.left,
                    latoFont,
                    false,
                  ),
                  addChildColumn(
                    "Toplam:" +
                        reservationDetail.reservationModel.cost.toString() +
                        " TL",
                    pw.TextAlign.left,
                    latoFont,
                    false,
                  ),
                  addChildColumn(
                    "Önemli: Tahsilat makbuzu almadan yapılan ödemeler geçersizdir.",
                    pw.TextAlign.left,
                    latoFont,
                    true,
                  ),
                ],
              ),
            ),
            addChildColumn(
              "MADDELER :",
              pw.TextAlign.left,
              latoFont,
              true,
            ),
            getMainContractList(latoFont, contractList),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(width: 20),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      addChildColumn("İLGİLİ PERSONEL",
                          pw.TextAlign.left, latoFont, true),
                    ],
                  ),
                ),
                pw.SizedBox(width: 20),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      addChildColumn("MÜŞTERİ",
                          pw.TextAlign.right, latoFont, true),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(child:
            addChildColumn(
              "EK 1",
              pw.TextAlign.left,
              latoFont,
              true,
            ),),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      addChildColumn(
                        "PAKET HARİCİ HİZMETLER",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      pw.SizedBox(height: 10),
                      getServicesListFromReservationDetail(latoFont, reservationDetail),
                      pw.SizedBox(height: 10),
                      addChildColumn(
                        "PAKET BİLGİLERİ",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      pw.SizedBox(height: 10),
                      addChildColumn(
                        packageTitle,
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      pw.SizedBox(height: 10),
                      addChildColumn(
                        packageBody,
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
                pw.SizedBox(width: 20),
              ],
            ),
          ],
        ),),
    );

    String fileName = "offer_" +
        new DateTime.now().millisecondsSinceEpoch.toString() + ".pdf";

    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final pdfFile = File('$tempPath/$fileName');
    await pdfFile.writeAsBytes(await pdf.save());

    OpenFile.open(pdfFile.path);
  }

  Future<void> createAndShowReservationPDFFromReservationDetail(BuildContext context,
      ReservationDetailViewDto reservationDetail) async {
    final pdf = pw.Document();
    pw.Font latoFont = await loadCustomFont('assets/fonts/Lato-Black.ttf');
    ProductsViewDetailModel productsViewDetailModel = ProductsViewDetailModel();
    String districtName = await productsViewDetailModel.getDistrict(
        int.parse(reservationDetail.corporateModel.district));
    String packageTitle = "";
    String packageBody = "";
    String sessionName = "";
    String contractBody = await getExtraContract();
    if (reservationDetail.packageModel != null) {
      packageTitle = reservationDetail.packageModel.title;
      packageBody = reservationDetail.packageModel.body;
    }
    if (reservationDetail.selectedSessionModel != null) {
      sessionName = reservationDetail.selectedSessionModel.name;
    }

    CorporateContractManagementViewModel contractManagementViewModel = CorporateContractManagementViewModel();
    List<CorporationMainContractModel> contractList = await contractManagementViewModel.getMainContractList(true);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        addChildColumn('Referans Kodu ' +
                            new DateTime.now().millisecondsSinceEpoch.toString(),
                            pw.TextAlign.left, latoFont, false),
                      ],),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        addChildColumn('İşlem Tarihi: ' +
                            DateConversionUtils.getCurrentViewTime(),
                            pw.TextAlign.right, latoFont, false),
                        addChildColumn(reservationDetail.corporateModel.address,
                            pw.TextAlign.right, latoFont, false),
                        addChildColumn(districtName,
                            pw.TextAlign.right, latoFont, false),
                        addChildColumn(reservationDetail.corporateModel.email,
                            pw.TextAlign.right, latoFont, false),
                        pw.SizedBox(height: 20),
                      ],),
                  ),
                ]),
            pw.SizedBox(height: 20),
            addChildColumn(reservationDetail.corporateModel.corporationName.toUpperCase() + " SATIŞ SÖZLEŞMESİ",
                pw.TextAlign.center, latoFont, true),
            pw.SizedBox(height: 20),

            pw.Center(child:
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      addChildColumn(
                        "MÜŞTERİ BİLGİLERİ",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      addChildColumn(
                        "İsim :" + reservationDetail.customerModel.name,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Soyisim :" + reservationDetail.customerModel.surname,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Cep Telefonu :" + reservationDetail.customerModel.gsmNo,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
                pw.SizedBox(width: 20),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      addChildColumn(
                        "ETKİNLİK BİLGİLERİ",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      addChildColumn(
                        "Etkinlik Tarihi :" +
                            DateConversionUtils.getCurrentViewTimeFromInt(
                                reservationDetail.reservationModel.date
                            ),
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Etkinlik Saati :" +
                            sessionName,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Etkinlik Türü :" +
                            reservationDetail.reservationModel.invitationType,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Oturma Düzeni :" +
                            reservationDetail.reservationModel.seatingArrangement,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Garanti Kişi Sayısı :" +
                            reservationDetail.reservationModel.invitationCount.toString(),
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Kişi Başı ÜCret : " +
                            (reservationDetail.reservationModel.cost /
                                reservationDetail.reservationModel.invitationCount).toStringAsFixed(2)+" TL",
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      addChildColumn(
                        "Paketin Adı :" + packageTitle,
                        pw.TextAlign.left,
                        latoFont,
                        false,
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            ),

            pw.SizedBox(width: 20),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  addChildColumn(
                    "ETKİNLİK ÖDEME TÜRÜ PLANLAMA",
                    pw.TextAlign.left,
                    latoFont,
                    true,
                  ),
                  addChildColumn(
                    "Ödeme Türü: Kaporalı",
                    pw.TextAlign.left,
                    latoFont,
                    false,
                  ),
                  addChildColumn(
                    "Toplam:" +
                        reservationDetail.reservationModel.cost.toString() +
                        " TL",
                    pw.TextAlign.left,
                    latoFont,
                    false,
                  ),
                  addChildColumn(
                    "Önemli: Tahsilat makbuzu almadan yapılan ödemeler geçersizdir.",
                    pw.TextAlign.left,
                    latoFont,
                    true,
                  ),
                ],
              ),
            ),
          ],
        ),),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(child: addChildColumn(
              "MADDELER2",
              pw.TextAlign.center,
              latoFont,
              true,
            ),),

            getMainContractList(latoFont, contractList),

            /*pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.SizedBox(width: 20),
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                addChildColumn("İLGİLİ PERSONEL",
                                    pw.TextAlign.left, latoFont, true),
                                pw.SizedBox(height: 20),
                              ],
                            ),
                          ),
                          pw.SizedBox(width: 20),
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                addChildColumn("MÜŞTERİ",
                                    pw.TextAlign.right, latoFont, true),
                                pw.SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
                pw.SizedBox(width: 20),
              ],
            ),*/
          ],
        ),),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(child:
            addChildColumn(
              "EK 1",
              pw.TextAlign.left,
              latoFont,
              true,
            ),),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      addChildColumn(
                        "PAKET HARİCİ HİZMETLER",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      pw.SizedBox(height: 10),
                      getServicesListFromReservationDetail(latoFont, reservationDetail),
                      pw.SizedBox(height: 10),
                      addChildColumn(
                        "PAKET BİLGİLERİ",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      pw.SizedBox(height: 10),
                      addChildColumn(
                        packageTitle,
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      pw.SizedBox(height: 10),
                      addChildColumn(
                        packageBody,
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
                pw.SizedBox(width: 20),
              ],
            ),
          ],
        ),),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(child:
            addChildColumn(
              "EK 2",
              pw.TextAlign.left,
              latoFont,
              true,
            ),),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      addChildColumn(
                        "HİZMET VEREN TARAFIN BELİRTTİĞİ SÖZLEŞME MADDELERİ",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      pw.SizedBox(height: 20),
                      addChildColumnForExtraContract(
                        contractBody,
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
                pw.SizedBox(width: 20),
              ],
            ),
          ],
        ),),
    );

    String fileName = "reservation_" +
        new DateTime.now().millisecondsSinceEpoch.toString() + ".pdf";

    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final pdfFile = File('$tempPath/$fileName');
    await pdfFile.writeAsBytes(await pdf.save());

    OpenFile.open(pdfFile.path);
  }

}