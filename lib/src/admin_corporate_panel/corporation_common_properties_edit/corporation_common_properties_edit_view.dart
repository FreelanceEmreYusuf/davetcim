import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/corporation_organizations_response_dto.dart';
import '../../../shared/dto/organization_type_response_dto.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../corporation_register/common_informations_p2/common_informations_p2_view_model.dart';
import '../../corporation_register/common_informations_p3/common_informations_p3_view_model.dart';
import '../../corporation_register/common_informations_p4/common_informations_p4_view_model.dart';
import '../AdminCorporatePanel.dart';
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
  CorporationOrganizationsResponseDto response = CorporationOrganizationsResponseDto(null, null, null);

  Map<String, bool> values = {};
  Map<String, int> valuesId = {};

  Map<String, bool> values2 = {};
  Map<String, int> valuesId2 = {};

  Map<String, bool> values3 = {};
  Map<String, int> valuesId3 = {};

  bool organizationErrorVisibility = false;
  bool invitationErrorVisibility = false;
  bool sequenceErrorVisibility = false;


  final registerFormKey = GlobalKey <FormState> ();
  final registerFormKey2 = GlobalKey <FormState> ();
  final registerFormKey3 = GlobalKey <FormState> ();
  @override
  void initState() {
    callGetOrganizationTypes();
  }

  void callGetOrganizationTypes() async {
    CorporationCommonPropertiesEditViewModel model = CorporationCommonPropertiesEditViewModel();
    response = await  model.getCorporationOrganizationTypes(ApplicationSession.userSession.corporationId);
    values = response.organizationTypeResponse.organizationTypeCheckedMap;
    valuesId = response.organizationTypeResponse.organizationTypeNameIdMap;
    values2 = response.invitationTypeResponse.organizationTypeCheckedMap;
    valuesId2 = response.invitationTypeResponse.organizationTypeNameIdMap;
    values3 = response.sequenceOrderResponse.organizationTypeCheckedMap;
    valuesId3 = response.sequenceOrderResponse.organizationTypeNameIdMap;

    setState(() {
      response = response;
      values = values;
      valuesId = valuesId;
      values2 = values2;
      valuesId2 = valuesId2;
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
    onPressed: () {
      List<String> organizationUniqueIdentifier = [];
      values.forEach((k, v) =>  {
        if (v) {
          organizationUniqueIdentifier.add(valuesId[k].toString()),
        }
      });

      List<String> invitationUniqueIdentifier = [];
      values2.forEach((k, v) =>  {
        if (v) {
          invitationUniqueIdentifier.add(valuesId2[k].toString()),
        }
      });

      List<String> sequenceOrderIdentifier = [];
      values3.forEach((k, v) =>  {
        if (v) {
          sequenceOrderIdentifier.add(valuesId3[k].toString()),
        }
      });

      if (organizationUniqueIdentifier.length == 0) {
        setState(() {
          organizationErrorVisibility = true;
        });
      } else if (invitationUniqueIdentifier.length == 0) {
        setState(() {
          invitationErrorVisibility = true;
        });
      } else if (sequenceOrderIdentifier.length == 0) {
        setState(() {
          sequenceErrorVisibility = true;
        });
      } else {
        CorporationCommonPropertiesEditViewModel viewModel = CorporationCommonPropertiesEditViewModel();
        viewModel.setCorporationOrganizationTypes(ApplicationSession.userSession.corporationId,
            organizationUniqueIdentifier,
            invitationUniqueIdentifier,
            sequenceOrderIdentifier);
        Utils.navigateToPage(context, AdminCorporatePanelPage());
      }
    },
    child: const Center(
    child: Text('Güncelle', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
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
            Visibility(
                visible: organizationErrorVisibility,
                child: Container(
                    child: Text("Lütfen Salon Özelliği Seçiniz", style: TextStyle(color: Colors.red)),
                    padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
                )),
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
            Visibility(
                visible: invitationErrorVisibility,
                child: Container(
                    child: Text("Lütfen Davet Türü Seçiniz", style: TextStyle(color: Colors.red)),
                    padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
                )),
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
            Visibility(
                visible: sequenceErrorVisibility,
                child: Container(
                    child: Text("Lütfen Masa Türü Seçiniz", style: TextStyle(color: Colors.red)),
                    padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
                )),
            SizedBox(height:  MediaQuery.of(context).size.height / 4.0,),
          ],
        ),
      ),
    );
  }
}
