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
  @override
  Widget build(BuildContext contex){
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          List<String> sequenceOrderList = [];
          values.forEach((k, v) =>  {
            if (v) {
              sequenceOrderList.add(valuesId[k].toString())
            }
          });
          widget.corpReg.corporationModel.sequenceOrderUniqueIdentifier = sequenceOrderList;
          Utils.navigateToPage(context, CommonInformationsP5View(corpReg: widget.corpReg,));
        },
        label: const Text('Devam Et'),
        icon: const Icon(Icons.navigate_next),
        backgroundColor: Colors.redAccent,
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
