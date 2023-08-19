import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
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
import '../../../widgets/checkbox_listtile_item.dart';
import '../../search/search_view_model.dart';
import '../common_informations_p4/common_informations_p4_view.dart';
import 'common_informations_p3_view_model.dart';

class CommonInformationsP3View extends StatefulWidget {
  @override
  _CommonInformationsP3ViewState createState() => _CommonInformationsP3ViewState();
  final CorporationReservationDto corpReg;

  CommonInformationsP3View(
      {Key key,
        @required this.corpReg,
       })
      : super(key: key);
}

class _CommonInformationsP3ViewState extends State<CommonInformationsP3View> {
  Map<String, bool> values = {};
  Map<String, int> valuesId = {};
  OrganizationTypesResponseDto response;
  final registerFormKey = GlobalKey <FormState> ();
  bool keyVisibility = false;
  @override
  void initState() {
    callGetInvitationTypes();
  }

  void callGetInvitationTypes() async {
    CommonInformationsP3ViewModel commonInformationsP3ViewModel = CommonInformationsP3ViewModel();
    response = await  commonInformationsP3ViewModel.getInvitationTypes();
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
            String invitationTypes = "";
            List<String> invitationIdentifierList = [];
            values.forEach((k, v) =>  {
              if (v) {
                invitationIdentifierList.add(valuesId[k].toString()),
                if (invitationTypes.isNotEmpty) {
                  invitationTypes += ", "
                },
                invitationTypes = invitationTypes + k,
              }
            });
            widget.corpReg.corporationModel.invitationUniqueIdentifier = invitationIdentifierList;
            widget.corpReg.invitationTypes = invitationTypes;
            Utils.navigateToPage(context, CommonInformationsP4View(corpReg: widget.corpReg,));
          },
          label: const Text('Devam Et'),
          icon: const Icon(Icons.navigate_next),
          backgroundColor: Colors.redAccent,
        ),
      ),
      appBar: AppBarMenu(pageName: "Sunulan Davet Türleri", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
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
