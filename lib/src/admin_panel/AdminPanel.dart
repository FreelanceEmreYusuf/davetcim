import 'package:davetcim/src/admin_panel/service/service_view.dart';
import 'package:davetcim/widgets/app_bar/app_bar_view.dart';
import 'package:flutter/material.dart';
import '../../shared/environments/const.dart';
import '../../shared/utils/utils.dart';
import 'company/company_add_view.dart';
import 'corporation/corporation_generate_key_view.dart';
import 'manage_corporation_active_passive/corporation_active_passive_view.dart';
import 'manage_lookups/manage_lookups_view.dart';


class AdminPanelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<AdminPanelPage> {
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
                        child: Text("YENİ FİRMA EKLE",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, CompanyAddView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 25,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("YENİ SALON EKLE",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, CorporationGenerateKeyView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 25,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("SALON AKTİF/PASİF",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, CorporationActivePassiveView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 25,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("HİZMET HAVUZU",
                          style: TextStyle(
                          color: Colors.white,
                        ),),
                        onPressed: () {
                          Utils.navigateToPage(context, AdminServicePoolManager());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 25,),
                  Container(
                      height: MediaQuery.of(context).size.height / 13,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50, 0, MediaQuery.of(context).size.width / 50, 0),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, elevation: 10, shadowColor: Colors.redAccent),
                        child: Text("SALON ÖZELLİK YÖNET",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        onPressed: () {
                          Utils.navigateToPage(context, ManageLookupsView());
                        },
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 20,),
                ],
              )),
        ));
  }
}
