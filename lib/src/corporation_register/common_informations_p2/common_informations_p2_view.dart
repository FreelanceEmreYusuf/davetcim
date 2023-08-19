import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/corporation_register/common_informations_p3/common_informations_p3_view.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:davetcim/widgets/checkbox_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/corporation_registration_dto.dart';
import '../../../shared/dto/organization_type_response_dto.dart';
import '../../../shared/models/company_model.dart';
import '../../../shared/models/corporation_model.dart';
import '../../../shared/models/region_model.dart';
import '../../../shared/sessions/application_session.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../search/search_view_model.dart';
import 'common_informations_p2_view_model.dart';

class CommonInformationsP2View extends StatefulWidget {
  @override
  _CommonInformationsP2ViewState createState() => _CommonInformationsP2ViewState();
  final CorporationReservationDto corpReg;

  CommonInformationsP2View(
      {Key key,
        @required this.corpReg,
       })
      : super(key: key);
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
            widget.corpReg.corporationModel.organizationUniqueIdentifier = organizationUniqueIdentifier;
            widget.corpReg.organizationTypes = organizationTypes;
            Utils.navigateToPage(context, CommonInformationsP3View(corpReg: widget.corpReg));
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
