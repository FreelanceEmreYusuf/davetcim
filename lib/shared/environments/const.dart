import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Constants {
  static String appName = "Davetcim";
  static String errorImg = "assets/errorimage.jpeg";

  static int vipCorporationAdditionPoint = 1000;
  static int reservationAdditionPoint = 10;
  static int favoriteAdditionPoint = 2;
  static int threeStarAdditionPoint = 3;
  static int fourStarAdditionPoint = 4;
  static int fiveStarAdditionPoint = 5;

  static String orderMessage = "Teklifi onayladığınız takdirde mekan sahibi tarafından aranacaksınız, arandığınızda indirim yaptırabilirsiniz, teklif aşamasında hesaplanan fiyat indirimsiz fiyattır, "+
      "mekan sahibiyle anlaşmanız durumunda önce teklifiniz opsiyon aşamasına çekilecektir "+
      "ve sizden belirli bir süre içerisinde kapora göndermeniz istenecektir, teklifiniz opsiyon aşamasına alındıktan sonra size bildirim gelecektir ayrıca bir başkası davetcim uygulaması üzerinden "+
      "sizin anlaştığınız tarih ve seans için teklifte bulunamayacaktır, mekan sahibine kaporayı göndermeniz sonrasında işleminiz satışa çevrilmiş olacaktır. "+
      "Finansal hiçbir işlem davetcim uygulaması üzerinden gerçekleşmez, para transferleri mekan sahibi ve müşteri arasında gerçekleşir, bu süreçte "+
      "iki tarafıda korumak için davetcim uygulaması üzerinden oluşturulan teklif ve satış sözleşmeleri iki tarafın kendi arasında birbirlerine gönderdikleri okudum onayladım mesajlarıyla "+
      "hukuksal geçerlilik kazanır ve bu şekilde dileyen müşteriler mekana hiç gitmeden sözleşmeli bir şekilde mekanı uzaktan rezerve edebilir, "+
      "sözleşmeler davetcim tarafından saklanmaz, iki taraf onayladım mesajlarını ve sözleşmeleri saklamakla mükelleftir.";


  //Colors for theme
//  Color(0xfffcfcff);
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.red;
  static Color darkAccent = Colors.red[400];
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color ratingBG = Colors.yellow[600];

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    //cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    //cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );

  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //db constants
  static String customerDB = "Customer";
  static String productDb = "Products";
  static String codeCategoriesDb = "CodeCategories";
  static String configurationDb = "Configuration";
  static String userDb = "User";
  static String secretQuestionsDb = "SecretQuestions";
  static String productCommentsDb = "Comments";
  static String notificationsDb = "Notifications";
  static String basketDb = "Basket";
  static String basketDetailDb = "BasketDetail";
  static String contactInfoDb = "ContactInfo";
  static String usersFavProductsDb = "UsersFavProducts";

  static double ratePoint = 3.0;
}
