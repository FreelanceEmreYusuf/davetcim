import 'package:davetcim/shared/sessions/application_context.dart';
import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../shared/dto/reservation_detail_view_dto.dart';
import '../shared/models/reservation_model.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/all_reservation/all_reservation_corporate_view_model.dart';
import '../src/user_reservations/update/user_reservation_update_reservation_order_view.dart';

class UserReservationUpdateCalenderOrderCarousel extends StatefulWidget {
  @override
  _UserReservationUpdateCalenderOrderCarouselState createState() => _UserReservationUpdateCalenderOrderCarouselState();
}

class _UserReservationUpdateCalenderOrderCarouselState extends State<UserReservationUpdateCalenderOrderCarousel> {

  List<ReservationModel> reservationList;

  EventList<Event> reservationDates = new EventList<Event>(
    events: {
      new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      ],
    },
  );

  bool hasDataTaken = false;

  @override
  void initState() {
    ///tüm rezervasoynları for döngüsüyle dönerek _markedDateMap nesnesine add edicez
    /// Add more events to _markedDateMap EventList
    super.initState();
    getReservationDates(ApplicationContext.reservationDetail.corporateModel.corporationId);
  }

  void getReservationDates(int corporationId) async {
    AllReservationCorporateViewModel model = AllReservationCorporateViewModel();
    reservationList = await model.getAllReservationlist(corporationId);

    for (int i = 0; i < reservationList.length; i++) {
      reservationDates.add(
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
      reservationDates = reservationDates;
      hasDataTaken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime _currentDate = DateTime.now();
    if (!hasDataTaken) {
      return Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Center(child: CircularProgressIndicator()));
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate = date);
          ApplicationContext.reservationDetail.reservationModel.date = DateConversionUtils.getCurrentDateAsInt(date);
          Utils.navigateToPage(context, UserReservationUpdateReservationOrderViewScreen());
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
        markedDatesMap: reservationDates,
        height:  MediaQuery.of(context).size.height / 1.6,
        isScrollable: true,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: true, /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
}
}