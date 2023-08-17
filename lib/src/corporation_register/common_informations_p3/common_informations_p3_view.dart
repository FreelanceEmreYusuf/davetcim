import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:davetcim/widgets/checkbox_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/corporation_registration_dto.dart';
import '../../../shared/models/company_model.dart';
import '../../../shared/models/corporation_model.dart';
import '../../../shared/models/region_model.dart';
import '../../../shared/sessions/application_session.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/checkbox_listtile_item.dart';
import '../../search/search_view_model.dart';
import '../common_informations_p4/common_informations_p4_view.dart';

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
  Map<String, bool> values = {
    'Düğün': false,
    'Kına': false,
    'Nişan': false,
    'Doğum Günü Organizasyonu': false,
  };
  final registerFormKey = GlobalKey <FormState> ();
  @override
  void initState() {
  }

  @override
  Widget build(BuildContext contex){
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Utils.navigateToPage(context, CommonInformationsP4View(corpReg: widget.corpReg,));
        },
        label: const Text('Devam Et'),
        icon: const Icon(Icons.navigate_next),
        backgroundColor: Colors.redAccent,
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
