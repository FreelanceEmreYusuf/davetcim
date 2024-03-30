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
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, textStyle: TextStyle(color: Colors.white,)),
                      child: Expanded(
                        child: Text("YENİ FİRMA EKLE",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ),
                      onPressed: () {
                        Utils.navigateToPage(context, CompanyAddView());
                      },
                    )),
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, textStyle: TextStyle(color: Colors.white,)),
                      child: Expanded(
                        child: Text("YENİ SALON EKLE", 
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ),
                      onPressed: () {
                        Utils.navigateToPage(context, CorporationGenerateKeyView());
                      },
                    )),
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent, textStyle: TextStyle(color: Colors.white,)),
                      child: Expanded(
                        child: Text("SALON AKTİF/PASİF", 
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ),
                      onPressed: () {
                        Utils.navigateToPage(context, CorporationActivePassiveView());
                      },
                    )),
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent),
                      child: Expanded(
                        child: Text("HİZMET HAVUZU", 
                          style: TextStyle(
                          color: Colors.white,
                        ),),
                      ),
                      onPressed: () {
                        Utils.navigateToPage(context, AdminServicePoolManager());
                      },
                    )),
                SizedBox(height: 30.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constants.darkAccent),
                      child: Expanded(
                        child: Text("SALON ÖZELLİK YÖNET", 
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ),
                      onPressed: () {
                        Utils.navigateToPage(context, ManageLookupsView());
                      },
                    )),
              ],
            )));
  }
}
