import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../../../shared/models/reservation_model.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/indicator.dart';
import 'admin_change_reservation_order_view.dart';
import 'all_reservation_corporate_view_model.dart';


class AllReservationCorporateDelayDateScreen extends StatefulWidget {

  final ReservationModel reservationModel;
  AllReservationCorporateDelayDateScreen({Key key, this.reservationModel, })
      : super(key: key);

  @override
  _AllReservationCorporateDelayDateScreenState createState() => _AllReservationCorporateDelayDateScreenState();
}

class _AllReservationCorporateDelayDateScreenState extends State<AllReservationCorporateDelayDateScreen> {

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
    super.initState();
    getReservationDates(widget.reservationModel);

  }

  void getReservationDates(ReservationModel reservationModel) async {
    AllReservationCorporateViewModel model = AllReservationCorporateViewModel();
    reservationList = await model.getAllReservationlistForCalendar(reservationModel.corporationId);

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
    if (!hasDataTaken ) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Yeni Rezervasyon Tarihi Seçin", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: Indicator())));
    }

    DateTime _firsDate = DateTime.now();
    return Scaffold(
      appBar: AppBarMenu(pageName: "Yeni Rezervasyon Tarihi Seçin", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: CalendarCarousel<Event>(
          onDayPressed: (DateTime date, List<Event> events) {
            Utils.navigateToPage(context, AdminChangeReservationOrderViewScreen(
                widget.reservationModel,
                DateConversionUtils.getCurrentDateAsInt(date)
            ));
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
          selectedDateTime: _firsDate,

          daysHaveCircularBorder: true, /// null for not rendering any border, true for circular border, false for rectangular border
        ),
      ),
    );
  }
}