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
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/checkbox_listtile_item.dart';
import '../../search/search_view_model.dart';

class CommonInformationsP5View extends StatefulWidget {
  @override
  _CommonInformationsP5ViewState createState() => _CommonInformationsP5ViewState();
  final CorporationReservationDto corpReg;

  CommonInformationsP5View(
      {Key key,
        @required this.corpReg,
       })
      : super(key: key);
}

class _CommonInformationsP5ViewState extends State<CommonInformationsP5View> {
  @override
  void initState() {
  }

  @override
  Widget build(BuildContext contex){
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Utils.navigateToPage(context, SeansCorporateAddView());
        },
        label: const Text('Onayla'),
        backgroundColor: Colors.redAccent,
      ),
      appBar: AppBarMenu(pageName: "Özet", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body: Container(),
    );
  }
}
