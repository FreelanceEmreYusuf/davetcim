import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/carousel_calender_order_widget.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with AutomaticKeepAliveClientMixin<CalendarScreen> {
  static TextStyle kStyle =
      TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);

  int selectedSeatingArrangement = 0;
  int selectedInvitationIndex = 0;
  int selectedOrganizationIndex = 0;
  int _cardDivisionSize = 20;
  final TextEditingController _searchControl = new TextEditingController();

  DateTime date = DateTime.now().toLocal();
  DateTime time = DateTime.now().toLocal();
  DateTime endTime = DateTime.now().toLocal().add(new Duration(hours: 2));
  bool checkedValue = false;

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);


    return Scaffold(
      appBar: AppBarMenu(pageName: "Seans Seçimi", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Container(
        child: SingleChildScrollView(
          child: new Padding(child: CalenderOrderCarousel(),
              padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
