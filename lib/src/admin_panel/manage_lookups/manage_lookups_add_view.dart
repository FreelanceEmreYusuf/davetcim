import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../shared/environments/const.dart';
import '../../../shared/utils/form_control.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import 'manage_lookups_view.dart';
import 'manage_lookups_view_model.dart';


class LookupAddView extends StatefulWidget {
  final String dbTable;

  LookupAddView({
    Key key,
    @required this.dbTable,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LookupAddView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController sortingIndexController = TextEditingController();
  final registerFormKey = GlobalKey <FormState> ();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(pageName: "Salon Özellik Güncelleme", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: registerFormKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Özellik İsim Bilgisi",
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
                      controller: sortingIndexController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Özellik Sıra Bilgisi",
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
                            ManageLookupsViewModel manageLookupEditService = ManageLookupsViewModel();
                            await manageLookupEditService.addLookupItem(widget.dbTable,
                                nameController.text, int.parse(sortingIndexController.text));
                            Utils.navigateToPage(context, ManageLookupsView());
                          }
                        },
                      )),
                ],
              ),
            )));
  }


}
