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

    if (UserBasketState.userBasket.servicePoolModel != null) {
      for (int i = 0; i < UserBasketState.userBasket.servicePoolModel.length; i++) {
        ServicePoolModel servicePoolModel = UserBasketState.userBasket.servicePoolModel[i];
        if (!servicePoolModel.hasChild && servicePoolModel.companyHasService) {
          widgetList.add(
            addChildColumn(
              servicePoolModel.serviceName.replaceAll("-", ""),
              pw.TextAlign.right,
              font,
              false,
            ),
          );
        }
      }
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
            addChildColumn('Referans Kodu ' +
                new DateTime.now().millisecondsSinceEpoch.toString(),
                pw.TextAlign.left, latoFont, false),
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
            addChildColumn(UserBasketState.userBasket.corporationModel.corporationName.toUpperCase() + " TEKLİF",
                pw.TextAlign.center, latoFont, true),
            addChildColumn("BU TEKLİF 10 GÜN İÇİN GEÇERLİDİR. SÖZLEŞME YERİNE GEÇMEZ",
                pw.TextAlign.center, latoFont, true),
            pw.SizedBox(height: 20),


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
                            "MÜŞTERİ BİLGİLERİ",
                            pw.TextAlign.right,
                            latoFont,
                            true,
                          ),
                          addChildColumn(
                            "İsim :" + UserState.name,
                            pw.TextAlign.right,
                            latoFont,
                            false,
                          ),
                          addChildColumn(
                            "Soyisim :" + UserState.surname,
                            pw.TextAlign.right,
                            latoFont,
                            false,
                          ),
                          addChildColumn(
                            "Cep Telefonu :" + UserState.gsmNo,
                            pw.TextAlign.right,
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
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
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
                            pw.TextAlign.right,
                            latoFont,
                            true,
                          ),
                          getServicesList(latoFont),
                          pw.SizedBox(height: 20),
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
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
                          pw.SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
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

    String fileName = "offer_" +
        new DateTime.now().millisecondsSinceEpoch.toString() + ".pdf";

    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final pdfFile = File('$tempPath/$fileName');
    await pdfFile.writeAsBytes(await pdf.save());

    OpenFile.open(pdfFile.path);
  }
}