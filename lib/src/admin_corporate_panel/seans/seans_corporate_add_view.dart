import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_view_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/environments/const.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/utils/form_control.dart';
import '../../../widgets/app_bar/app_bar_view.dart';


class SeansCorporateAddView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SeansCorporateAddView> {
  TextEditingController sessionNameController = TextEditingController();
  TextEditingController midweekPriceController = TextEditingController();
  TextEditingController weekendPriceController = TextEditingController();
  final registerFormKey = GlobalKey <FormState> ();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(pageName: "Seans Ekle", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: registerFormKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: sessionNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Seans İsmi (Sabah Seansı 10:00-14:00)",
                      ),
                      validator: (value) {
                        return FormControlUtil.getErrorControl(FormControlUtil.getStringEmptyValueControl(value));
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: midweekPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hafta İçi Seans Ücreti (TL)",
                      ),
                      validator: (value) {
                        return FormControlUtil.getErrorControl(FormControlUtil.getStringEmptyValueControl(value));
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: weekendPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hafta Sonu Seans Ücreti (TL)",
                      ),
                      validator: (value) {
                        return FormControlUtil.getErrorControl(FormControlUtil.getStringEmptyValueControl(value));
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      // ignore: deprecated_member_use
                      child: MaterialButton(
                        textColor: Colors.white,
                        color: Constants.darkAccent,
                        child: Text("Ekle"),
                        onPressed: () async {
                          if (registerFormKey.currentState.validate()) {
                            CorporateSessionsViewModel service = CorporateSessionsViewModel();
                            await service.addNewSession(sessionNameController.text, int.parse(midweekPriceController.text),
                              int.parse(weekendPriceController.text));
                            Utils.navigateToPage(context, SeansCorporateView());
                          }
                        }
                      )),
                ],
              ),
            )));
  }


}
