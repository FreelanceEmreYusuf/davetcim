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

import '../../src/products/product_detail_view_model.dart';
import '../dto/reservation_detail_view_dto.dart';
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
        child: pw.ListView(
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
      child: pw.ListView(
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
    BuildContext buildContext;
    if (UserBasketState.userBasket.packageModel != null) {
      packageTitle = UserBasketState.userBasket.packageModel.title;
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
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                addChildColumn(
                  "1. Size ilettiğimiz teklif; ilgili gün ve tarih için verilmiştir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "2. Teklif brlirtilen kişi kapasitesi ve menü için geçerlidir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "3. İlgili zaman aralığı ve ilgili paketimizi satın alabilmek için rezervasyon/satış işlemi yaptırmanız gerekmektedir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "4. Teklif geçerlilik süreci 10 gündür.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "5. Bu belge sadece bir tekliftir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "6. Paket harici hizmetler EK 1 içerisinde listelenmektedir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                pw.SizedBox(height: 20),
              ],
            ),


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
                          pw.SizedBox(height: 20),
                          getServicesList(latoFont),
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

  pw.Widget getServicesListFromReservationDetail(pw.Font font,
      ReservationDetailViewDto reservationDetail) {
    List<pw.Widget> widgetList = [];

    if (reservationDetail.detailList == null) {
      return pw.Container(
        height: 20.0,
        child: pw.ListView(
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
      child: pw.ListView(
        children: widgetList,
      ),
    );
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
    BuildContext buildContext;
    if (reservationDetail.packageModel != null) {
      packageTitle = reservationDetail.packageModel.title;
    }
    if (reservationDetail.selectedSessionModel != null) {
      sessionName = reservationDetail.selectedSessionModel.name;
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
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                addChildColumn(
                  "1. Size ilettiğimiz teklif; ilgili gün ve tarih için verilmiştir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "2. Teklif brlirtilen kişi kapasitesi ve menü için geçerlidir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "3. İlgili zaman aralığı ve ilgili paketimizi satın alabilmek için rezervasyon/satış işlemi yaptırmanız gerekmektedir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "4. Teklif geçerlilik süreci 10 gündür.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "5. Bu belge sadece bir tekliftir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "6. Paket harici hizmetler EK 1 içerisinde listelenmektedir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                pw.SizedBox(height: 20),
              ],
            ),


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
                      pw.SizedBox(height: 20),
                      getServicesListFromReservationDetail(latoFont, reservationDetail),
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
    String sessionName = "";
    BuildContext buildContext;
    if (reservationDetail.packageModel != null) {
      packageTitle = reservationDetail.packageModel.title;
    }
    if (reservationDetail.selectedSessionModel != null) {
      sessionName = reservationDetail.selectedSessionModel.name;
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
              "MADDELER",
              pw.TextAlign.center,
              latoFont,
              true,
            ),),
            pw.Center(child:
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                addChildColumn(
                  "1. İş bu sözleşme bedelinin en az 1/3 ü cayma bedeli olarak nakit alınır.Peşin Ödeme Türünde toplam tutar alınır.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "2. Kalan bakiye tören günü takı merasiminden sonra nakden ve defaten ödenir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "3. Alınan cayma bedeli borçlar kanunun 156/2 maddesine göre tören sahibinin sözleşmeyi iptal etmesi durumunda iade edilmez.Peşin Ödeme Türünde 1/3 Cayma Bedeli düşülerek,kalan tutar iade edilir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "4. Etkinlik sahibi herhangi bir sebeple törenini iptal veya ileri bir tarihe ertelemek isterse 45 gün önceden yazılı olarak bildirmediği takdirde sözleşme tutarının tamamını ödemeyi kabul ve taahhüt eder.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "5. Etkinlik sahibi veya davetlilerin dışarıdan alkollü veya alkolsüz içecek ile her türlü yiyecek getirmeleri yasaktır.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "6. Etkinlik sırasında fotoğraf ve video çekimi hakkı salon müdüriyetinde ve yetkisindedir. Dışarıdan fotoğraf ve video kamerası getirilip çekim yapılamaz.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "7. Etkinlik anında salon müdüriyetinin idaresine müdahale edilemez. Organizasyon sahibi özel program ve sanatçı getirmek istediğinde salon müdüriyetine 1 gün önceden muafakat alarak haber vermek zorundadır. Sanatçı ve gruplar kendi ses tesisatlarını getireceklerdir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "8. Etkinlik süresince icra edilecek müzik seçimi ve yayını müşteri tarafından belirlenir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "9. İzine tabi organizasyonlarda mülki amirden izin alınması mecburi olup iş bu izini, organizasyon sahibi alacaktır. İzinin alınması ve organizasyon sırasında icra edilecek müziklere ait her türlü hukuki sorumluluk müşteriye aittir. Davetlilerin banner, flama, afiş vb. asması işletmemizin onayı ile yapılabilir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "10. Hesap kesimi sözleşmede belirtilen garanti kişi sayısı üzerinden alınır.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "11. Sözleşmede belirtilen garanti kişi sayısından fazla kişi gelir ise gelen her kişiye servis açılır ve ikram yapılır. Organizasyon sonunda organizasyon sahibinden doğacak fark tahsil edilir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "12. Misafirler etkinlik saatinden 30 dakika önce salona alınır.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                addChildColumn(
                  "13. Davete katılan herkes salon güvenliği tarafından kontrol edilir, hiçbir şekilde silah vb. malzemeler salona girişe müsaade edilmez.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "14. Müdüriyete teslim edilmeyen özel eşyaların kayıp ve çalıntısından işletmemiz sorumlu değildir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "15. Promosyon hizmetlerinin rezervasyonu etkinlik tarihinden 1 ay önce yapılmalıdır.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "16. Etkinlik tarihindan itibaren 1 ay içinde alınmayan fotoğraf ve video görüntülerinden firma fotoğraf servisimiz sorumlu değildir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "17. İş bu sözleşmeden kaynaklanan her türlü hukuki sorumluluk müşteriye aittir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "18. İş bu anlaşmadan doğacak ihtilaflardan Bakırköy Mahkemeleri yetkilidir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "19. İş bu sözleşme tarafların imzasıyla yürürlüğe girer.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "İş bu sözleşme esnek sözleşmedir. Pandemi vb tarafların dışında bir olayların olması durumunda",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "20. Kısıtlama durumunda ve yapmak isterseniz yapılamayan hizmet ve ikramların bedelleri ets sisteminden düşülerek satış fiyatı revize edilir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "21. İleri tarihe hiç bir fiyat farkı yansıtılmadan erteleme yapabilirsiniz.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "22. Töreninizi yapmak istemez iseniz 1/3 kapora badeliniz. Yanmaz. Ancak nakit olarak iade edilmez. Cari hesabınızda bulunan bu miktarı dilediğiniz zaman kullanabilirsiniz.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "23. Varsa Paket harici alınan hizmetler ve varsa paket içeriği EK 1 içerisinde listelenmektedir.",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),addChildColumn(
                  "24. Bu maddeler davetcimin her iki tarafı korumak için belirlediği standart maddelerdir, hizmet veren tarafın belirttiği sözleşme var ise EK 2'de yer alacaktır, EK 2'de belirtilen maddeler ile ilk 23 madde arasında bir çelişki oluşursa EK 2 deki madde baz alınacaktır. ",
                  pw.TextAlign.left,
                  latoFont,
                  false,
                ),
                pw.SizedBox(height: 20),
              ],
            ),
            ),
            pw.Row(
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
                      pw.SizedBox(height: 20),
                      getServicesListFromReservationDetail(latoFont, reservationDetail),
                      pw.SizedBox(height: 20),
                      addChildColumn(
                        "PAKET İÇERİĞİ",
                        pw.TextAlign.left,
                        latoFont,
                        true,
                      ),
                      pw.SizedBox(height: 20),
                      getServicesListFromReservationDetail(latoFont, reservationDetail),
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
                      getServicesListFromReservationDetail(latoFont, reservationDetail),
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