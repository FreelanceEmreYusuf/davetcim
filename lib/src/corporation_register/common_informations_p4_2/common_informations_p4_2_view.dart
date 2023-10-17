import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/corporation_registration_dto.dart';
import '../../../shared/dto/service_type_response_dto.dart';
import '../../../shared/enums/corporation_service_selection_enum.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../common_informations_p5/common_informations_p5_view.dart';
import 'common_informations_p4_2_view_model.dart';

class CommonInformationsP42View extends StatefulWidget {
  @override
  _CommonInformationsP42ViewState createState() => _CommonInformationsP42ViewState();
  final CorporationReservationDto corpReg;

  CommonInformationsP42View(
      {Key key,
        @required this.corpReg,
       })
      : super(key: key);
}

class _CommonInformationsP42ViewState extends State<CommonInformationsP42View> {
  Map<int, String> values = {};
  Map<int, bool> valuesChecked = {};
  ServiceTypesResponseDto response;
  final registerFormKey = GlobalKey <FormState> ();
  bool keyVisibility = false;
  @override
  void initState() {
    callGetServiceTypes();
  }

  void callGetServiceTypes()  {
    CommonInformationsP42ViewModel service = CommonInformationsP42ViewModel();
    response =  service.getServiceTypes();
    values = response.serviceTypeTitleMap;
    valuesChecked = response.serviceTypeChecked;

    setState(() {
      response = response;
      values = values;
      valuesChecked = valuesChecked;
    });
  }

  bool isListItemChecked() {
    bool isChecked = false;
    valuesChecked.forEach((k, v) =>  {
      if (v) {
        isChecked = true
      }
    });
    return isChecked;
  }

  @override
  Widget build(BuildContext contex){
    return Scaffold(
      floatingActionButton: Visibility(
        visible: keyVisibility,
        child: FloatingActionButton.extended(
          onPressed: () {
            int serviceSelectionCount = 0;
            int serviceSelectedValue = -1;
            valuesChecked.forEach((k, v) =>  {
              if (v) {
                serviceSelectionCount += 1,
                if (k == 0) serviceSelectedValue = 0,
                if (k == 1) serviceSelectedValue = 1,
              }
            });
            if (serviceSelectionCount > 1) serviceSelectedValue = 2;

            widget.corpReg.corporationModel.serviceSelection =
                CorporationServiceSelectionEnumConverter.getEnumValue(serviceSelectedValue);
            Utils.navigateToPage(context, CommonInformationsP5View(corpReg: widget.corpReg,));
          },
          label: const Text('Devam Et'),
          icon: const Icon(Icons.navigate_next),
          backgroundColor: Colors.redAccent,
        ),
      ),
      appBar: AppBarMenu(pageName: "Salon Hizmet & Paket Seçimi", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: Form(
          key: registerFormKey,
          child: new ListView(
            children: values.keys.map((int key) {
              return new CheckboxListTile(
                title: new Text(values[key]),
                value: valuesChecked[key],
                onChanged: (bool value) {
                  setState(() {
                    valuesChecked[key] = value;
                    keyVisibility = isListItemChecked();
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
