import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/corporation_registration_dto.dart';
import '../../../shared/dto/organization_type_response_dto.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../common_informations_p4_2/common_informations_p4_2_view.dart';
import '../common_informations_p5/common_informations_p5_view.dart';
import 'common_informations_p4_view_model.dart';

class CommonInformationsP4View extends StatefulWidget {
  @override
  _CommonInformationsP4ViewState createState() => _CommonInformationsP4ViewState();
  final CorporationReservationDto corpReg;

  CommonInformationsP4View(
      {Key key,
        @required this.corpReg,
       })
      : super(key: key);
}

class _CommonInformationsP4ViewState extends State<CommonInformationsP4View> {
  Map<String, bool> values = {};
  Map<String, int> valuesId = {};
  OrganizationTypesResponseDto response;
  final registerFormKey = GlobalKey <FormState> ();
  bool keyVisibility = false;
  @override
  void initState() {
    callGetSequenceOrderTypes();
  }

  void callGetSequenceOrderTypes() async {
    CommonInformationsP4ViewModel commonInformationsP4ViewModel = CommonInformationsP4ViewModel();
    response = await  commonInformationsP4ViewModel.getSequenceOrderTypes();
    values = response.organizationTypeCheckedMap;
    valuesId = response.organizationTypeNameIdMap;

    setState(() {
      response = response;
      values = values;
      valuesId = valuesId;
    });
  }

  bool isListItemChecked() {
    bool isChecked = false;
    values.forEach((k, v) =>  {
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
            String sequenceOrderTypes = "";
            List<String> sequenceOrderList = [];
            values.forEach((k, v) =>  {
              if (v) {
                sequenceOrderList.add(valuesId[k].toString()),
                if (sequenceOrderTypes.isNotEmpty) {
                  sequenceOrderTypes += ", "
                },
                sequenceOrderTypes = sequenceOrderTypes + k,
              }
            });
            widget.corpReg.corporationModel.sequenceOrderUniqueIdentifier = sequenceOrderList;
            widget.corpReg.sequenceOrderTypes = sequenceOrderTypes;
            Utils.navigateToPage(context, CommonInformationsP42View(corpReg: widget.corpReg,));
          },
          label: const Text('Devam Et'),
          icon: const Icon(Icons.navigate_next),
          backgroundColor: Colors.redAccent,
        ),
      ),
      appBar: AppBarMenu(pageName: "Sunulan Oturma Düzenleri", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: Form(
          key: registerFormKey,
          child: new ListView(
            children: values.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(key),
                value: values[key],
                onChanged: (bool value) {
                  setState(() {
                    values[key] = value;
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
