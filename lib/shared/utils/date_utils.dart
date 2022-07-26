
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


}