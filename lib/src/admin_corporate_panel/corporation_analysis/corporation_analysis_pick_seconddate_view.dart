import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import 'corporation_analysis_between_two_dates_view.dart';


class CorporationAnalysisSecondDatePickerView extends StatefulWidget {

  final DateTime startDate;
  CorporationAnalysisSecondDatePickerView(
      {Key key,
        @required this.startDate})
      : super(key: key);

  @override
  _CorporationAnalysisSecondDatePickerViewState createState() => _CorporationAnalysisSecondDatePickerViewState();
}

class _CorporationAnalysisSecondDatePickerViewState extends State<CorporationAnalysisSecondDatePickerView> {

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      ],
    },
  );


  @override
  Widget build(BuildContext context) {
    DateTime _secondDate = DateTime.now();
    return Scaffold(
      appBar: AppBarMenu(pageName: "Bitiş Tarihi Seçin", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: CalendarCarousel<Event>(
          onDayPressed: (DateTime date, List<Event> events) {
            this.setState(() => _secondDate = date);
            print("first date : "+widget.startDate.toString());
            print("second date : "+_secondDate.toString());
            Utils.navigateToPage(context, CorporationAnalysisBetweenTwoDateView(firstDate: widget.startDate, secondDate: _secondDate,));
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
          selectedDateTime: _secondDate,

          daysHaveCircularBorder: true, /// null for not rendering any border, true for circular border, false for rectangular border
        ),
      ),
    );
  }
}