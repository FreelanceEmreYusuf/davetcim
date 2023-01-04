import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_view.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service-corporate_view_model.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_view.dart';
import 'package:davetcim/src/admin_panel/service/service_view.dart';
import 'package:davetcim/src/admin_panel/service/service_view_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/environments/const.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/utils/form_control.dart';
import '../../../widgets/app_bar/app_bar_view.dart';


class SeansCorporateAddView extends StatefulWidget {
  final ServicePoolModel servicePoolModel;

  SeansCorporateAddView({
    Key key,
    @required this.servicePoolModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SeansCorporateAddView> {
  TextEditingController priceController = TextEditingController();
  bool checkedCountPriceValue = false;
  bool hasPrice = false;
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
                      controller: priceController,
                      keyboardType: TextInputType.number,
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
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hafta İçi Saatlik Seans Ücreti (TL)",
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
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hafta Sonu Saatlik Seans Ücreti (TL)",
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
                          /*if (registerFormKey.currentState.validate()) {
                            ServiceCorporatePoolViewModel service = ServiceCorporatePoolViewModel();
                            await service.addNewService(widget.servicePoolModel,  int.parse(priceController.text), checkedCountPriceValue);*/
                            Utils.navigateToPage(context, SeansCorporateView());
                          }
                        //},
                      )),
                ],
              ),
            )));
  }


}
