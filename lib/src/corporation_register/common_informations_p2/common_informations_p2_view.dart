import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/corporation_registration_dto.dart';
import '../../../shared/models/company_model.dart';
import '../../../shared/models/corporation_model.dart';
import '../../../shared/models/region_model.dart';
import '../../../shared/sessions/application_session.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../search/search_view_model.dart';

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
  final TextEditingController maxCapacityControl = new TextEditingController();
  final registerFormKey = GlobalKey <FormState> ();
  String formException = "";
  int _cardDivisionSize = 20;
  static TextStyle kStyle =
  TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);
  List<RegionModel> regionList =
      ApplicationSession.filterScreenSession.regionModelList;
  int selectedRegion = 0;
  int selectedDistrict = 0;
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext contex){
    callFillDistrict(regionList[selectedRegion].id);
    return Scaffold(
      appBar: AppBarMenu(pageName: "Salon Bilgi Girişi", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body:
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: Form(
          key: registerFormKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Maksimum Kapasite",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.account_balance,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: maxCapacityControl,
                validator: (name) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(name));
                },
                maxLines: 1,
              ),//İsim
              SizedBox(height: 15.0),

              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 4.0),
                height: 40.0,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.redAccent,),
                  child: Text(
                    "Devam Et".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (registerFormKey.currentState.validate()) {



                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void callFillDistrict(int regionCode) async {
    SearchViewModel rm = SearchViewModel();
    districtList = await rm.fillDistrictlist(regionCode);
    setState(() {
      districtList = districtList;
    });
  }
}
