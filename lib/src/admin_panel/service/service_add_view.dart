import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/admin_panel/service/service_view.dart';
import 'package:davetcim/src/admin_panel/service/service_view_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/environments/const.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/utils/form_control.dart';
import '../../../widgets/app_bar/app_bar_view.dart';


class ServiceAddView extends StatefulWidget {
  final ServicePoolModel servicePoolModel;

  ServiceAddView({
    Key key,
    @required this.servicePoolModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ServiceAddView> {
  TextEditingController serviceController = TextEditingController();
  bool checkedValue;
  final registerFormKey = GlobalKey <FormState> ();

  @override
  void initState() {
    checkedValue = false;
    setState(() {
      checkedValue = checkedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(pageName: "Hizmet Havuzu Ekle", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: registerFormKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: serviceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Servis Adı",
                      ),
                      validator: (value) {
                        return FormControlUtil.getErrorControl(FormControlUtil.getStringEmptyValueControl(value));
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    child: CheckboxListTile(
                      title: Text("Alt kırılımı olacak mı?"),
                      value: checkedValue,
                      onChanged: (newValue) {
                        setState(() {
                          checkedValue = newValue;
                        });
                      },
                      controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
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
                            ServicePoolViewModel service = ServicePoolViewModel();
                            await service.addNewService(serviceController.text, checkedValue, widget.servicePoolModel.id);
                            Utils.navigateToPage(context, AdminServicePoolManager());
                          }
                        },
                      )),
                ],
              ),
            )));
  }


}
