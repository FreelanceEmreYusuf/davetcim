import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import 'corporation_analysis_pick_firstdate_view.dart';

class CorporationAnalysisView extends StatefulWidget {
  @override
  _CorporationAnalysisViewState createState() => _CorporationAnalysisViewState();
  final  List<Widget> commentList;

  CorporationAnalysisView(
      {Key key,
      @required this.commentList})
      : super(key: key);
}

class _CorporationAnalysisViewState extends State<CorporationAnalysisView> {

  bool firstCalenderVisibility = false;
  bool secondtCalenderVisibility = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Utils.navigateToPage(context, CorporationAnalysisFirstDatePickerView());
          },
          label: Text('2 Tarih Arasını Filtrele', style: TextStyle(fontSize: 15), maxLines: 2),
          icon: Icon(Icons.search),
          backgroundColor: Colors.redAccent,
        ),
      ),
        appBar: AppBarMenu(pageName: "Salon Analiz Sayfası", isHomnePageIconVisible: true, isNotificationsIconVisible: false, isPopUpMenuActive: true),
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
                subtitle: Text(
                  "Bugün",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
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
            SizedBox(height: 10,),
            Card(
              elevation: 10.0,
              child: ListTile(
                title: Text("Ziyaretçi sayısı"),
                subtitle: Text(
                  "Son 1 Ay",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Icon(
                  FontAwesomeIcons.search,
                  size: 25.0,
                  color: Theme.of(context).accentColor,
                ),
                trailing: Text("3995", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.redAccent,
                ),),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              elevation: 10.0,
              child: ListTile(
                title: Text("Ziyaretçi sayısı"),
                subtitle: Text(
                  "Son 1 Yıl",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Icon(
                  FontAwesomeIcons.search,
                  size: 25.0,
                  color: Theme.of(context).accentColor,
                ),
                trailing: Text("17563", style: TextStyle(
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
                subtitle: Text(
                  "Bugün",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
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
            SizedBox(height: 10,),
            Card(
              elevation: 10.0,
              child: ListTile(
                title: Text("Rezervasyon sayısı"),
                subtitle: Text(
                  "Son 1 Ay",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Icon(
                  FontAwesomeIcons.search,
                  size: 25.0,
                  color: Theme.of(context).accentColor,
                ),
                trailing: Text("89", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.redAccent,
                ),),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              elevation: 10.0,
              child: ListTile(
                title: Text("Rezervasyon sayısı"),
                subtitle: Text(
                  "Son 1 Yıl",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Icon(
                  FontAwesomeIcons.search,
                  size: 25.0,
                  color: Theme.of(context).accentColor,
                ),
                trailing: Text("1256", style: TextStyle(
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
