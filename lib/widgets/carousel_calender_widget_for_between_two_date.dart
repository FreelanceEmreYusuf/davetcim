import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../shared/models/reservation_model.dart';
import '../shared/utils/utils.dart';
import '../src/reservation/reservation_view.dart';

class CalenderCarouselBetweenTwoDate extends StatefulWidget {


  CalenderCarouselBetweenTwoDate({Key key, })
  : super(key: key);

  @override
  _CalenderCarouselBetweenTwoDateState createState() => _CalenderCarouselBetweenTwoDateState();
}

class _CalenderCarouselBetweenTwoDateState extends State<CalenderCarouselBetweenTwoDate> {

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      ],
    },
  );


  @override
  Widget build(BuildContext context) {
    DateTime _firsDate = DateTime.now();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _firsDate = date);
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
        weekFormat: false,
        markedDatesMap: _markedDateMap,
        height:  MediaQuery.of(context).size.height / 1.6,
        isScrollable: true,
        selectedDateTime: _firsDate,

        daysHaveCircularBorder: true, /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
}
}