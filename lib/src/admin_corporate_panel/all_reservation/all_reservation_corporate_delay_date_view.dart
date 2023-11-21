import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../../../shared/models/reservation_model.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../AdminCorporatePanel.dart';
import 'all_reservation_corporate_view.dart';
import 'all_reservation_corporate_view_model.dart';


class AllReservationCorporateDelayDateScreen extends StatefulWidget {

  final ReservationModel reservationModel;
  AllReservationCorporateDelayDateScreen({Key key, this.reservationModel, })
      : super(key: key);

  @override
  _AllReservationCorporateDelayDateScreenState createState() => _AllReservationCorporateDelayDateScreenState();
}

class _AllReservationCorporateDelayDateScreenState extends State<AllReservationCorporateDelayDateScreen> {

  @override
  Widget build(BuildContext context) {

    DateTime dtReservationDate = DateConversionUtils.getDateTimeFromIntDate(widget.reservationModel.date);
    EventList<Event> _markedDateMap = new EventList<Event>(
      events: {
        dtReservationDate: [
        ],
      },
    );

    DateTime _firsDate = dtReservationDate;
    return Scaffold(
      appBar: AppBarMenu(pageName: "Yeni Rezervasyon Tarihi Seçin", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: CalendarCarousel<Event>(
          onDayPressed: (DateTime date, List<Event> events) {
            AllReservationCorporateViewModel allReservationCorporateViewModel = AllReservationCorporateViewModel();
            allReservationCorporateViewModel.delayReservation(context, widget.reservationModel,
                DateConversionUtils.getCurrentDateAsInt(date));
            Utils.navigateToPage(context, AllReservationCorporateView());
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
      ),
    );
  }
}