import 'package:flutter/material.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_package/service_corporate_package_view_model.dart';
import '../../../../shared/environments/const.dart';
import '../../../../shared/models/corporation_package_services_model.dart';
import '../../../../shared/utils/form_control.dart';
import '../../../../widgets/app_bar/app_bar_view.dart';
import '../service_landing_view.dart';

class ServiceCorporatePackageAddView extends StatefulWidget {
  final CorporationPackageServicesModel packageModel;

  ServiceCorporatePackageAddView({
    Key key,
    @required this.packageModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ServiceCorporatePackageAddView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(
        pageName: "Salon Paket Ekleme",
        isHomnePageIconVisible: true,
        isNotificationsIconVisible: true,
        isPopUpMenuActive: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: registerFormKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Paket Başlığı",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return FormControlUtil.getErrorControl(
                    FormControlUtil.getStringEmptyValueControl(value),
                  );
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: bodyController,
                keyboardType: TextInputType.text,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: "Paket İçeriği",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return FormControlUtil.getErrorControl(
                    FormControlUtil.getStringEmptyValueControl(value),
                  );
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Kişi Başı Paket Fiyatı",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return FormControlUtil.getErrorControl(
                    FormControlUtil.getStringEmptyValueControl(value),
                  );
                },
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                padding: EdgeInsets.zero,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Constants.darkAccent,
                  ),
                  onPressed: () async {
                    if (registerFormKey.currentState.validate()) {
                      ServiceCorporatePackageViewModel packageService = ServiceCorporatePackageViewModel();
                      await packageService.addPackageItem(
                        titleController.text,
                        bodyController.text,
                        int.parse(priceController.text),
                      );
                      Utils.navigateToPage(context, ServiceLandingView(pageIndex: 1));
                    }
                  },
                  child: Text("Ekle", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
