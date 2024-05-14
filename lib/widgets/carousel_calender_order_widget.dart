import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../shared/sessions/user_basket_state.dart';
import '../shared/utils/utils.dart';
import '../src/reservation/reservation_order_view.dart';

class CalenderOrderCarousel extends StatefulWidget {
  @override
  _CalenderOrderCarouselState createState() => _CalenderOrderCarouselState();
}

class _CalenderOrderCarouselState extends State<CalenderOrderCarousel> {

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
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
    if (UserBasketState.userBasket == null || UserBasketState.userBasket.reservationList == null) {
      return;
    }
    for (int i = 0; i < UserBasketState.userBasket.reservationList.length; i++) {
      _markedDateMap.add(
          DateConversionUtils.getDateTimeFromIntDate(UserBasketState.userBasket.reservationList[i].date),
          new Event(
            date: DateConversionUtils.getDateTimeFromIntDate(
                UserBasketState.userBasket.reservationList[i].date),
            title: UserBasketState.userBasket.reservationList[i].description,
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
          if (date != null ) {
            this.setState(() => _currentDate = date);
            UserBasketState.userBasket.date = DateConversionUtils.getCurrentDateAsInt(date);
            Utils.navigateToPage(context, ReservationOrderViewScreen());
          }
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
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: true, /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
}
}