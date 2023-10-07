import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../shared/environments/const.dart';
import '../../../../shared/models/corporation_package_services_model.dart';
import '../../../../shared/utils/form_control.dart';
import '../../../../widgets/app_bar/app_bar_view.dart';
import '../service_landing_view.dart';

class ServiceCorporatePackageEditView extends StatefulWidget {
  final CorporationPackageServicesModel packageModel;

  ServiceCorporatePackageEditView({
    Key key,
    @required this.packageModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ServiceCorporatePackageEditView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final registerFormKey = GlobalKey <FormState> ();

  @override
  void initState() {
    titleController.text = widget.packageModel.title;
    bodyController.text =  widget.packageModel.body;
    priceController.text = widget.packageModel.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(pageName: "Salon Paket Güncelleme", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: registerFormKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Paket Başlığı",
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
                      maxLines: 12,
                      textDirection: TextDirection.ltr,
                      controller: bodyController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Paket İçeriği",
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
                        labelText: "Kişi Başı Paket Fiyatı",
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
                        child: Text("Güncelle"),
                        onPressed: () async {
                          if (registerFormKey.currentState.validate()) {
                            ServiceCorporatePackageViewModel packageService = ServiceCorporatePackageViewModel();
                            await packageService.editPackageItem(widget.packageModel,
                                titleController.text,  bodyController.text, int.parse(priceController.text));
                            Utils.navigateToPage(context, ServiceLandingView(pageIndex: 1));
                          }
                        },
                      )),
                ],
              ),
            )));
  }
}
