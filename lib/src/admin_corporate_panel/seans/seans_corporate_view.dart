import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_add_view.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_view_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/corporate_sessions_model.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/seans_corporate_card_widget.dart';


class SeansCorporateView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SeansCorporateView> {
  List<CorporateSessionsModel> sessionsList = [];
  final registerFormKey = GlobalKey <FormState> ();

  @override
  void initState() {
    callGetSessions();
    super.initState();
  }

  void callGetSessions() async {
    CorporateSessionsViewModel model = CorporateSessionsViewModel();
    sessionsList = await model.getSessions();

    setState(() {
      sessionsList = sessionsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(pageName: "Seans Yönetimi", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Divider(),
            SizedBox(height: 10.0),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 12),
              ),
              itemCount: sessionsList == null
                  ? 0
                  : sessionsList.length,
              itemBuilder: (BuildContext context, int index) {
                CorporateSessionsModel item = sessionsList[index];
                return SeansCorporateCardWidget(model: item);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Utils.navigateToPage(context, SeansCorporateAddView());
        },
        label: const Text('Seans Ekle'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}

