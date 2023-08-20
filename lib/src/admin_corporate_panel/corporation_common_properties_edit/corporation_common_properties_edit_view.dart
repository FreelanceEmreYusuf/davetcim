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
import '../../corporation_register/common_informations_p3/common_informations_p3_view_model.dart';
import '../../corporation_register/common_informations_p4/common_informations_p4_view_model.dart';
import '../../search/search_view_model.dart';
import 'corporation_common_properties_edit_view_model.dart';

class CorporationCommonPropertiesEditView extends StatefulWidget {
  @override
  _CorporationCommonPropertiesEditViewState createState() => _CorporationCommonPropertiesEditViewState();


  CorporationCommonPropertiesEditView(
      {Key key,
       })
      : super(key: key);
}

class _CorporationCommonPropertiesEditViewState extends State<CorporationCommonPropertiesEditView> {
  Map<String, bool> values = {};
  Map<String, int> valuesId = {};

  Map<String, bool> values2 = {};
  Map<String, int> valuesId2 = {};

  Map<String, bool> values3 = {};
  Map<String, int> valuesId3 = {};


  OrganizationTypesResponseDto response;
  OrganizationTypesResponseDto response2;
  OrganizationTypesResponseDto response3;
  final registerFormKey = GlobalKey <FormState> ();
  final registerFormKey2 = GlobalKey <FormState> ();
  final registerFormKey3 = GlobalKey <FormState> ();
  @override
  void initState() {
    callGetOrganizationTypes();
    callGetInvitationTypes();
    callGetSequenceOrderTypes();
  }

  void callGetOrganizationTypes() async {
    CorporationCommonPropertiesEditViewModel commonInformationsP2ViewModel = CorporationCommonPropertiesEditViewModel();
    response = await  commonInformationsP2ViewModel.getOrganizationTypes();
    values = response.organizationTypeCheckedMap;
    valuesId = response.organizationTypeNameIdMap;

    setState(() {
      response = response;
      values = values;
      valuesId = valuesId;
    });
  }

  void callGetInvitationTypes() async {
    CommonInformationsP3ViewModel commonInformationsP3ViewModel = CommonInformationsP3ViewModel();
    response2 = await  commonInformationsP3ViewModel.getInvitationTypes();
    values2 = response2.organizationTypeCheckedMap;
    valuesId2 = response2.organizationTypeNameIdMap;

    setState(() {
      response2 = response2;
      values2 = values2;
      valuesId2 = valuesId2;
    });
  }

  void callGetSequenceOrderTypes() async {
    CommonInformationsP4ViewModel commonInformationsP4ViewModel = CommonInformationsP4ViewModel();
    response3 = await  commonInformationsP4ViewModel.getSequenceOrderTypes();
    values3 = response3.organizationTypeCheckedMap;
    valuesId3 = response3.organizationTypeNameIdMap;

    setState(() {
      response3 = response3;
      values3 = values3;
      valuesId3 = valuesId3;
    });
  }



  @override
  Widget build(BuildContext contex){
    return Scaffold(
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
        height: MediaQuery.of(context).size.height / 14.0,
        margin: const EdgeInsets.all(10),
    child: MaterialButton(
      color: Colors.redAccent,
    onPressed: () {},
    child: const Center(
    child: Text('Güncelle', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    ),
    ),
        ),
      appBar: AppBarMenu(pageName: "Salon Özellikleri", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: ListView(
          children: [
            SizedBox(height:  MediaQuery.of(context).size.height / 50.0,),
            Container(
              padding: const EdgeInsets.only(left: 14.0, top: 14.0),
              child: Text("Salon Özellikleri",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
              ),
            ),
            Divider(thickness: 2,),
            Form(
              key: registerFormKey,
              child: new Column(
                children: values.keys.map((String key) {
                  return new CheckboxListTile(
                    title: new Text(key),
                    value: values[key],
                    onChanged: (bool value) {
                      setState(() {
                        values[key] = value;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height:  MediaQuery.of(context).size.height / 25.0,),
            Container(
              padding: const EdgeInsets.only(left: 14.0, top: 14.0),
              child: Text("Sunulan Davet Türleri",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
              ),
            ),
            Divider(thickness: 2,),
            Form(
              key: registerFormKey2,
              child: new Column(
                children: values2.keys.map((String key) {
                  return new CheckboxListTile(
                    title: new Text(key),
                    value: values2[key],
                    onChanged: (bool value) {
                      setState(() {
                        values2[key] = value;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height:  MediaQuery.of(context).size.height / 25.0,),
            Container(
              padding: const EdgeInsets.only(left: 14.0, top: 14.0),
              child: Text("Sunulan Masa Düzenleri",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
              ),
            ),
            Divider(thickness: 2,),
            Form(
              key: registerFormKey3,
              child: new Column(
                children: values3.keys.map((String key) {
                  return new CheckboxListTile(
                    title: new Text(key),
                    value: values3[key],
                    onChanged: (bool value) {
                      setState(() {
                        values3[key] = value;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height:  MediaQuery.of(context).size.height / 4.0,),
          ],
        ),
      ),
    );
  }
}
