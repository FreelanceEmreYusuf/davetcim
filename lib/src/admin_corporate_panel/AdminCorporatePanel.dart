import 'package:davetcim/src/admin_corporate_panel/manage_comments/manage_comment_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_view.dart';
import 'package:davetcim/src/admin_panel/service/service_view.dart';
import 'package:davetcim/src/home/home_view.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/widgets/app_bar/app_bar_view.dart';
import 'package:flutter/material.dart';

import '../../shared/environments/const.dart';
import '../../widgets/reservation_corporate_card_widget.dart';
import 'all_reservation/all_reservation_corporate_view.dart';
import 'corporation_analysis/corporation_analysis_view.dart';
import 'corporation_common_properties_edit/corporation_common_properties_edit_view.dart';
import 'manage_corporation_photos/manage_corporation_photos_view.dart';
import 'manage_corporation_photos/pick_page.dart';


class AdminCorporatePanelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<AdminCorporatePanelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(pageName: "Admin Paneli", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent),
                      child: Text("SUNULAN HİZMET İŞLEMLERİ",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return AdminCorporateServicePoolManager();
                          },
                        ));
                      },
                    )),
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent),
                      child: Text("SEANS İŞLEMLERİ",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SeansCorporateView();
                          },
                        ));
                      },
                    )),
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent),
                      child: Text("REZERVASYON İŞLEMLERİ",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ReservationCorporateView();
                          },
                        ));
                      },
                    )),
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent),
                      child: Text("REZERVASYON GEÇMİŞİ",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return AllReservationCorporateView();
                          },
                        ));
                      },
                    )),
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent),
                      child: Text("YORUMLARI DÜZENLE",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ManageCommentCorporateView();
                          },
                        ));
                      },
                    )),
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent),
                      child: Text("SALON ANALİZİ",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return CorporationAnalysisView();
                          },
                        ));
                      },
                    )),
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent),
                      child: Text("SALON ÖZELLİKLERİNİ YÖNET",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return CorporationCommonPropertiesEditView();
                          },
                        ));
                      },
                    )),
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent),
                      child: Text("FOTOĞRAFLARI YÖNET",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return PickPageView();
                          },
                        ));
                      },
                    )),

              ],
            )));
  }
}
