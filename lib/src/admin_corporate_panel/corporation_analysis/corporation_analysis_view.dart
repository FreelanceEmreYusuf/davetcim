import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../shared/models/corporation_event_log_model.dart';
import '../../../shared/sessions/user_state.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/indicator.dart';
import 'corporation_analysis_pick_firstdate_view.dart';
import 'corporation_analysis_view_model.dart';

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
  CorporationEventLogModel corporationEventLogModel;
  bool hasDataTaken = false;

  @override
  void initState() {
    getScreenModel();
    super.initState();
  }

  void getScreenModel() async {
    CorporationAnalysisViewModel corporationAnalysisViewModel = CorporationAnalysisViewModel();
    corporationEventLogModel = await corporationAnalysisViewModel.getLogForScreen(
        UserState.corporationId);
    setState(() {
      corporationEventLogModel = corporationEventLogModel;
      hasDataTaken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Salon Analiz Sayfası", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: Indicator())));
    }

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
        appBar: AppBarMenu(pageName: "Salon Analiz Sayfası", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: InkWell(
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 20,),
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
                          trailing: Text(corporationEventLogModel.visitCount.toString(), style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
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
                          trailing: Text(corporationEventLogModel.visitCountMonth.toString(), style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
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
                          trailing: Text(corporationEventLogModel.visitCountYear.toString(), style: TextStyle(
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

            SizedBox(height: MediaQuery.of(context).size.height / 20,),
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
                            "Bugün",
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
                      Card(
                        elevation: 10.0,
                        child: ListTile(
                          title: Text("Favoriye eklenme sayısı"),
                          subtitle: Text(
                            "Son 1 Ay",
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
                          trailing: Text(corporationEventLogModel.favoriteCountMonth.toString(), style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
                      Card(
                        elevation: 10.0,
                        child: ListTile(
                          title: Text("Favoriye eklenme sayısı"),
                          subtitle: Text(
                            "Son 1 Yıl",
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
                          trailing: Text(corporationEventLogModel.favoriteCountYear.toString(), style: TextStyle(
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

            SizedBox(height: MediaQuery.of(context).size.height / 20,),
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
                            "Bugün",
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
                            "Bugün",
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
                            FontAwesomeIcons.marker,
                            size: 25.0,
                            color: Theme.of(context).accentColor,
                          ),
                          trailing: Text(corporationEventLogModel.reservationCountMonth.toString(), style: TextStyle(
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
                            "Son 1 Ay",
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
                          trailing: Text(corporationEventLogModel.reservationTotalAmountMonth.toString() + " TL", style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
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
                            FontAwesomeIcons.marker,
                            size: 25.0,
                            color: Theme.of(context).accentColor,
                          ),
                          trailing: Text(corporationEventLogModel.reservationCountYear.toString(), style: TextStyle(
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
                            "Son 1 Yıl",
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
                          trailing: Text(corporationEventLogModel.reservationTotalAmountYear.toString() + " TL", style: TextStyle(
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

            SizedBox(height: MediaQuery.of(context).size.height / 20,),
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
                            "Bugün",
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
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
                      Card(
                        elevation: 10.0,
                        child: ListTile(
                          title: Text("Yapılan yorum sayısı"),
                          subtitle: Text(
                            "Son 1 Ay",
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
                          trailing: Text(corporationEventLogModel.commentCountMonth.toString(), style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50,),
                      Card(
                        elevation: 10.0,
                        child: ListTile(
                          title: Text("Yapılan yorum sayısı"),
                          subtitle: Text(
                            "Son 1 Yıl",
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
                          trailing: Text(corporationEventLogModel.commentCountYear.toString(), style: TextStyle(
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


          ],
        ),
      ),
      );
  }
}
