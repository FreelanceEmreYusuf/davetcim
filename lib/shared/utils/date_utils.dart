
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateConversionUtils {
  static String getCurrentViewTime() {
    return new DateTime.now().day.toString().padLeft(2, '0') + "."
        + DateTime.now().month.toString().padLeft(2, '0')  + "."
        + DateTime.now().year.toString();
  }

  static String getCurrentViewTimeFromInt(int intDate) {
    DateTime dt = getDateTimeFromIntDate(intDate);
    return dt.day.toString().padLeft(2, '0') + "."
        + dt.month.toString().padLeft(2, '0')  + "."
        + dt.year.toString();
  }

  static int getCurrentDateAsInt(DateTime dt) {
    return  int.parse(""  + dt.year.toString()  +
        dt.month.toString().padLeft(2, '0')  + dt.day.toString().padLeft(2, '0'));
  }

  static int getCurrentTimeAsInt(DateTime dt) {
    return  int.parse(""  + dt.hour.toString()  +
        dt.second.toString().padLeft(2, '0'));
  }

  static int getTodayAsInt() {
    return  getCurrentDateAsInt(DateTime.now());
  }

  static DateTime getDateTimeFromIntDate(int intDate) {
    return DateTime(int.parse(intDate.toString().substring(0, 4)),
      int.parse(intDate.toString().substring(4, 6)),
      int.parse(intDate.toString().substring(6, 8))
    );
  }

  static String dateTimeToString(DateTime dateTime) {
    return DateFormat('dd MM yyyy', 'tr_TR').format(dateTime);
  }

  static String intDateToString(int intDate) {
    DateTime dt = getDateTimeFromIntDate(intDate);
    return DateFormat('dd.MM.yyyy').format(dt);
  }

  static int getWeekDayFromIntDate(int intDate) {
    DateTime dt = getDateTimeFromIntDate(intDate);
    return dt.weekday;
  }

  static bool isWeekendFromIntDate(int intDate) {
    int weekDay = getWeekDayFromIntDate(intDate);
    return (weekDay == 6) || (weekDay == 7);
  }

  static String convertIntTimeToString(int timeInt) {
    String timeStr = timeInt.toString().padLeft(4, '0');
    return timeStr.substring(0, 2) + ":" + timeStr.substring(2, 4);
  }

  static String convertIntTimeToViewString(int timeInt) {
    String timeStr = timeInt.toString();
    return timeStr.substring(6, 8) + "." + timeStr.substring(4, 6) + "." + timeStr.substring(0, 4);
  }

  static bool isOldDate (DateTime dt) {
    return dt.isBefore(DateTime.now().add(const Duration(days: -1)));
  }

  static String convertTimestampToString (int timestamp) {
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String datetime = tsdate.day.toString() + "/" + tsdate.month.toString() + "/" + tsdate.year.toString();
    return datetime;
  }

  static String getTimestampToDateString (Timestamp timestamp) {
    DateTime tsdate =  timestamp.toDate();
    String datetime = tsdate.day.toString() + "/" + tsdate.month.toString() + "/" + tsdate.year.toString();
    return datetime;
  }

  static String timestampToString(Timestamp timestamp) {
    DateTime tsdate =  timestamp.toDate();
    final DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm:ss');
    return formatter.format(tsdate);
  }

  static int getDayDifferenceFromToday (Timestamp timestamp) {
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    return DateTime.now().difference(tsdate).inDays;
  }

}