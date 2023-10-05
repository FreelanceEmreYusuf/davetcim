import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_user_choose/service-corporate_view_model.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_user_choose/service_corporate_view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/environments/const.dart';
import '../../../../shared/models/service_corporate_pool_model.dart';
import '../../../../shared/utils/form_control.dart';
import '../../../../widgets/app_bar/app_bar_view.dart';


class ServiceCorporateUpdateView extends StatefulWidget {
  final ServiceCorporatePoolModel serviceCorporatePoolModel;

  ServiceCorporateUpdateView({
    Key key,
    @required this.serviceCorporatePoolModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ServiceCorporateUpdateView> {
  TextEditingController priceController = TextEditingController();
  bool checkedCountPriceValue = false;
  bool hasPrice = false;
  final registerFormKey = GlobalKey <FormState> ();

  @override
  void initState() {
    priceController.text = widget.serviceCorporatePoolModel.price.toString();
    checkedCountPriceValue =  widget.serviceCorporatePoolModel.priceChangedForCount;

    setState(() {
      checkedCountPriceValue = checkedCountPriceValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(pageName: "Salon Hizmet Yönetimi", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
                        labelText: "Fiyat (Ücretisiz ise 0 giriniz)",
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
                      title: Text("Fiyat kişi sayısına göre çarpılacak mı?"),
                      value: checkedCountPriceValue,
                      onChanged: (newValue) {
                        setState(() {
                          checkedCountPriceValue = newValue;
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
                        child: Text("Güncelle"),
                        onPressed: () async {
                          if (registerFormKey.currentState.validate()) {
                            ServiceCorporatePoolViewModel service = ServiceCorporatePoolViewModel();
                            await service.updateService(widget.serviceCorporatePoolModel,  int.parse(priceController.text), checkedCountPriceValue);
                            Utils.navigateToPage(context, AdminCorporateServicePoolManager());
                          }
                        },
                      )),
                ],
              ),
            )));
  }


}
