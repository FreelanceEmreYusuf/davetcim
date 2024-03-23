import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../shared/models/reservation_model.dart';
import '../shared/sessions/application_context.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/all_reservation/all_reservation_corporate_view_model.dart';
import '../src/admin_corporate_panel/reservation/reservation_only_for_corporate_view.dart';
import '../src/reservation/reservation_all_order_view.dart';
import '../src/reservation/reservation_view.dart';

class CalenderCorporateAdminCarousel extends StatefulWidget {

  @override
  _CalenderCorporateAdminCarouselState createState() => _CalenderCorporateAdminCarouselState();
}

class _CalenderCorporateAdminCarouselState extends State<CalenderCorporateAdminCarousel> {

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      ],
    },
  );

  List<ReservationModel> reservationList = [];
  bool hasDataTaken = false;

  @override
  void initState() {
    super.initState();
    loadDates();
  }

  void loadDates() async {
    AllReservationCorporateViewModel model = AllReservationCorporateViewModel();
    reservationList = await model.getAllReservationlistForCalendar(ApplicationContext.userCache.corporationId);

    _markedDateMap.clear();
    for (int i = 0; i < reservationList.length; i++) {
      _markedDateMap.add(
          DateConversionUtils.getDateTimeFromIntDate(reservationList[i].date),
          new Event(
            date: DateConversionUtils.getDateTimeFromIntDate(reservationList[i].date),
            title: reservationList[i].description,
            //icon: Icon(Icons.access_alarms, color: Colors.blueAccent),
            dot: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              color: Colors.blueAccent,
              height: 5.0,
              width: 5.0,
            ),
          ));
    }

    setState(() {
      reservationList = reservationList;
      _markedDateMap = _markedDateMap;
      hasDataTaken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime _currentDate = DateTime.now();

    if (!hasDataTaken) {
      return Scaffold(body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Center(child: CircularProgressIndicator())));
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate = date);
          Utils.navigateToPage(context, ReservationOnlyForCorporateViewScreen(ApplicationContext.userCache.corporationId, date));
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