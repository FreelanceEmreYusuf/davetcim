import 'package:davetcim/src/admin_corporate_panel/AdminCorporatePanel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../shared/models/corporation_event_log_model.dart';
import '../../../shared/sessions/application_context.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import 'corporation_analysis_view_model.dart';

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

  CorporationEventLogModel corporationEventLogModel;
  bool hasDataTaken = false;

  @override
  void initState() {
    getScreenModel();
    super.initState();
  }

  void getScreenModel() async {
    CorporationAnalysisViewModel corporationAnalysisViewModel = CorporationAnalysisViewModel();
    corporationEventLogModel = await corporationAnalysisViewModel.getLogBetweenDates(ApplicationContext.userCache.corporationId, widget.firstDate, widget.secondDate);
    setState(() {
      corporationEventLogModel = corporationEventLogModel;
      hasDataTaken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String date = widget.firstDate.toString().substring(0,10)+" - "+widget.secondDate.toString().substring(0,10);
    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: date, isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: CircularProgressIndicator())));
    }

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Utils.navigateToPage(context, AdminCorporatePanelPage());
          },
          label: Text('Admin Paneline Dön', style: TextStyle(fontSize: 15), maxLines: 2),
          icon: Icon(Icons.keyboard_backspace),
          backgroundColor: Colors.redAccent,
        ),
      ),
      appBar: AppBarMenu(pageName: date, isHomnePageIconVisible: true, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body: InkWell(
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 50,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    color: Colors.redAccent),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
                      Card(
                        elevation: 10.0,
                        child: ListTile(
                          title: Text("Ziyaretçi sayısı"),
                          subtitle: Text(
                            date,
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
                          trailing: Text(corporationEventLogModel.visitCount.toString(), style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height / 50,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40)),
                    color: Colors.redAccent),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
                      Card(
                        elevation: 10.0,
                        child: ListTile(
                          title: Text("Favoriye eklenme sayısı"),
                          subtitle: Text(
                            date,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.solidHeart,
                            size: 25.0,
                            color: Theme.of(context).accentColor,
                          ),
                          trailing: Text(corporationEventLogModel.favoriteCount.toString(), style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height / 50,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    color: Colors.redAccent),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
                      Card(
                        elevation: 10.0,
                        child: ListTile(
                          title: Text("Rezervasyon sayısı"),
                          subtitle: Text(
                            date,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.marker,
                            size: 25.0,
                            color: Theme.of(context).accentColor,
                          ),
                          trailing: Text(corporationEventLogModel.reservationCount.toString(), style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: ListTile(
                          title: Text("Toplam Ciro"),
                          subtitle: Text(
                            date,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.solidMoneyBillAlt,
                            size: 25.0,
                            color: Theme.of(context).accentColor,
                          ),
                          trailing: Text(corporationEventLogModel.reservationTotalAmount.toString() + " TL", style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height / 50,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40)),
                    color: Colors.redAccent),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
                      Card(
                        elevation: 10.0,
                        child: ListTile(
                          title: Text("Yapılan yorum sayısı"),
                          subtitle: Text(
                            date,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.comment,
                            size: 25.0,
                            color: Theme.of(context).accentColor,
                          ),
                          trailing: Text(corporationEventLogModel.commentCount.toString(), style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
