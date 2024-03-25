import 'package:davetcim/src/corporation_register/common_informations_p3/common_informations_p3_view.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/organization_type_response_dto.dart';
import '../../../shared/sessions/corporation_registration_state.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import 'common_informations_p2_view_model.dart';

class CommonInformationsP2View extends StatefulWidget {
  @override
  _CommonInformationsP2ViewState createState() => _CommonInformationsP2ViewState();
}

class _CommonInformationsP2ViewState extends State<CommonInformationsP2View> {
  Map<String, bool> values = {};
  Map<String, int> valuesId = {};
  OrganizationTypesResponseDto response;
  final registerFormKey = GlobalKey <FormState> ();
  bool keyVisibility = false;
  @override
  void initState() {
    callGetOrganizationTypes();
  }

  void callGetOrganizationTypes() async {
    CommonInformationsP2ViewModel commonInformationsP2ViewModel = CommonInformationsP2ViewModel();
    response = await  commonInformationsP2ViewModel.getOrganizationTypes();
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
            String organizationTypes = "";
            List<String> organizationUniqueIdentifier = [];
            values.forEach((k, v) =>  {
              if (v) {
                organizationUniqueIdentifier.add(valuesId[k].toString()),
                if (organizationTypes.isNotEmpty) {
                  organizationTypes += ", "
                },
                organizationTypes = organizationTypes + k,
              }
            });
            CorporationRegistrationState.corporationReservation.corporationModel.organizationUniqueIdentifier =
                organizationUniqueIdentifier;
            CorporationRegistrationState.corporationReservation.organizationTypes = organizationTypes;
            Utils.navigateToPage(context, CommonInformationsP3View());
          },
          label: const Text('Devam Et'),
          icon: const Icon(Icons.navigate_next),
          backgroundColor: Colors.redAccent,
        ),
      ),
      appBar: AppBarMenu(pageName: "Sunulan Salon Tipleri", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body:
      Padding(
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
