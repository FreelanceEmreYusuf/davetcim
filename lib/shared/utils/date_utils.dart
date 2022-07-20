
class DateUtils {
  static int getCurrentDateAsInt() {
    return  int.parse(""  + DateTime.now().year.toString()  +
        DateTime.now().month.toString() + DateTime.now().day.toString());
  }
}