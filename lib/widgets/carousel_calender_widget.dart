import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../shared/models/reservation_model.dart';
import '../shared/utils/utils.dart';
import '../src/reservation/reservation_view.dart';

class CalenderCarousel extends StatefulWidget {

  //final IconData icon;
  final List<ReservationModel> reservationList;
  final int corporationId;

  CalenderCarousel({Key key, @required this.reservationList, this.corporationId})
  : super(key: key);

  @override
  _CalenderCarouselState createState() => _CalenderCarouselState();
}

class _CalenderCarouselState extends State<CalenderCarousel> {

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
        /*new Event(
          date: new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
          title: 'Event 1',
          //icon: Icon(Icons.access_alarms, color: Colors.blueAccent),
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.blueAccent,
            height: 5.0,
            width: 5.0,
          ),
        ),*/
      ],
    },
  );

  @override
  void initState() {
    ///tüm rezervasoynları for döngüsüyle dönerek _markedDateMap nesnesine add edicez
    /// Add more events to _markedDateMap EventList
    loadDates();
    super.initState();
  }

  void loadDates() {
    _markedDateMap.clear();
    for (int i = 0; i < widget.reservationList.length; i++) {
      _markedDateMap.add(
          DateConversionUtils.getDateTimeFromIntDate(widget.reservationList[i].date),
          new Event(
            date: DateConversionUtils.getDateTimeFromIntDate(widget.reservationList[i].date),
            title: widget.reservationList[i].description,
            //icon: Icon(Icons.access_alarms, color: Colors.blueAccent),
            dot: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              color: Colors.blueAccent,
              height: 5.0,
              width: 5.0,
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime _currentDate = DateTime.now();
    loadDates();
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: CalendarCarousel<Event>(
    onDayPressed: (DateTime date, List<Event> events) {
      this.setState(() => _currentDate = date);
      Utils.navigateToPage(context, ReservationViewScreen(widget.corporationId, date));
    },
    weekendTextStyle: TextStyle(
    color: Colors.red,
    ),
    locale:  "tr",
    thisMonthDayBorderColor: Colors.transparent,
    daysTextStyle: TextStyle(color: Colors.redAccent),
    headerTextStyle: TextStyle(color: Colors.redAccent, fontSize: 20),
    leftButtonIcon: Icon(Icons.arrow_left, color: Colors.redAccent),
    rightButtonIcon: Icon(Icons.arrow_right, color: Colors.redAccent),
    selectedDayButtonColor: Colors.redAccent,
    selectedDayTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
    selectedDayBorderColor: Colors.redAccent,
    /*customDayBuilder: (   /// you can provide your own build function to make custom day containers
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
            ) {*/
    /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
    /// This way you can build custom containers for specific days only, leaving rest as default.

    // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
    /*if (day.day == 15) {
            return Center(
              child: Icon(Icons.access_alarms, color: Colors.red),
            );
          } else {
            return null;

  },  }*/
  weekFormat: false,
  markedDatesMap: _markedDateMap,
  height:  MediaQuery.of(context).size.height / 1.7,
  selectedDateTime: _currentDate,
  daysHaveCircularBorder: true, /// null for not rendering any border, true for circular border, false for rectangular border
  ),
  );
}
}