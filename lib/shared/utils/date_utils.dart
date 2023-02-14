
class DateConversionUtils {
  static int getCurrentDateAsInt(DateTime dt) {
    return  int.parse(""  + dt.year.toString()  +
        dt.month.toString().padLeft(2, '0')  + dt.day.toString().padLeft(2, '0'));
  }

  static int getCurrentTimeAsInt(DateTime dt) {
    return  int.parse(""  + dt.hour.toString()  +
        dt.second.toString().padLeft(2, '0'));
  }

  static DateTime getDateTimeFromIntDate(int intDate) {
    return DateTime(int.parse(intDate.toString().substring(0, 4)),
      int.parse(intDate.toString().substring(4, 6)),
      int.parse(intDate.toString().substring(6, 8))
    );
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

}