import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/carousel_calender_widget_for_between_two_date.dart';
import '../../../widgets/cupertino_date_picker.dart';
import 'corporation_analysis_pick_firstdate_view.dart';

class CorporationAnalysisBetweenTwoDateView extends StatefulWidget {
  @override
  _CorporationAnalysisBetweenTwoDateViewState createState() => _CorporationAnalysisBetweenTwoDateViewState();
  final  DateTime firstDate;
  final  DateTime secondDate;

  CorporationAnalysisBetweenTwoDateView(
      {Key key,
        @required this.firstDate,
        @required this.secondDate})
      : super(key: key);
}

class _CorporationAnalysisBetweenTwoDateViewState extends State<CorporationAnalysisBetweenTwoDateView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(pageName: widget.firstDate.toString().substring(0,10)+" & "+widget.secondDate.toString().substring(0,10), isHomnePageIconVisible: true, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body: InkWell(
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            SizedBox(height: 25,),
            Card(
              elevation: 10.0,
              child: ListTile(
                title: Text("Ziyaretçi sayısı"),
                subtitle: Expanded(
                  child: Text(
                    widget.firstDate.toString().substring(0,10)+" & "+widget.secondDate.toString().substring(0,10)+" tarihleri arası", maxLines: 3,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                leading: Icon(
                  FontAwesomeIcons.search,
                  size: 25.0,
                  color: Theme.of(context).accentColor,
                ),
                trailing: Text("115", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.redAccent,
                ),),
              ),
            ),
            Divider(color: Colors.redAccent, height: 25, thickness: 5.0),
            Card(
              elevation: 10.0,
              child: ListTile(
                title: Text("Rezervasyon sayısı"),
                subtitle: Expanded(
                  child: Text(
                    widget.firstDate.toString().substring(0,10)+" & "+widget.secondDate.toString().substring(0,10)+" tarihleri arası", maxLines: 3,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                leading: Icon(
                  FontAwesomeIcons.search,
                  size: 25.0,
                  color: Theme.of(context).accentColor,
                ),
                trailing: Text("5", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.redAccent,
                ),),
              ),
            ),

          ],
        ),
      ),
      );
  }
}
