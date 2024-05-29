import 'package:davetcim/shared/sessions/corporation_registration_state.dart';
import 'package:davetcim/shared/sessions/state_management.dart';
import 'package:davetcim/src/admin_corporate_panel/manage_comments/manage_comment_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_landing_view.dart';
import 'package:davetcim/widgets/app_bar/app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../shared/environments/const.dart';
import '../../shared/utils/utils.dart';
import 'all_reservation/all_reservation_corporate_landing_view.dart';
import 'corporation_analysis/corporation_analysis_view.dart';
import 'corporation_common_properties_edit/corporation_common_properties_edit_view.dart';
import 'corporation_contract_management/corporate_contract_management_view.dart';
import 'corporation_populerity_rank/corporate_contract_management_view.dart';
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors:[Color.fromRGBO(233, 211, 98, 1.0),Color.fromARGB(203, 173, 109, 99),Color.fromARGB(51, 51, 51, 1),]
            ),
          ),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height / 20,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("SUNULAN HİZMET İŞLEMLERİ",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, ServiceLandingView(pageIndex: 0,));
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 30,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("SEANS İŞLEMLERİ",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, SeansCorporateView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 30,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("REZERVASYON İŞLEMLERİ",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, ReservationCorporateView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 30,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("REZERVASYON GEÇMİŞİ",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, AllReservationLandingView(pageIndex: 0));
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 30,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("YORUMLARI DÜZENLE",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, ManageCommentCorporateView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 30,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("SALON ANALİZİ",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, CorporationAnalysisView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 30,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("POPULERLİK BİLGİSİ ",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, CorporationPopularityRankView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 30,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("SALON ÖZELLİKLERİNİ YÖNET",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, CorporationCommonPropertiesEditView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 30,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("SÖZLEŞMELERİ YÖNET",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, ServiceCorporatePackageAddView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 30,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("FOTOĞRAFLARI YÖNET",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, PickPageView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 20,),

                ],
              )),
        ));
  }

  @override
  void initState() {
    StateManagement.disposeStates();
    super.initState();
  }
}
