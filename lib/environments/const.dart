import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Constants {
  static String appName = "Davetcim";

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
    cursorColor: lightAccent,
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
    cursorColor: darkAccent,
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
  static String productCommentsDb = "ProductComments";
  static String notificationsDb = "Notifications";
  static String basketDb = "Basket";
  static String basketDetailDb = "BasketDetail";
  static String contactInfoDb = "ContactInfo";
  static String usersFavProductsDb = "UsersFavProducts";
}
