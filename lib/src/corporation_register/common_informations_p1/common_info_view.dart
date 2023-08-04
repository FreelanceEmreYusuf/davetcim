import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/region_model.dart';
import '../../../shared/sessions/application_session.dart';
import '../../search/search_view_model.dart';
import 'common_informations_p1_view_model.dart';

class CommonInformationsView extends StatefulWidget {
  @override
  _CommonInformationsViewState createState() => _CommonInformationsViewState();
}

class _CommonInformationsViewState extends State<CommonInformationsView> {
  final TextEditingController _addresControl = new TextEditingController();
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _phoneControl = new TextEditingController();
  final TextEditingController _nameControl = new TextEditingController();
  final TextEditingController _descriptionControl = new TextEditingController();
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
      body:
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: Form(
          key: registerFormKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 25.0,
                ),
                child: Text(
                  "Salon Bilgi Girişi",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Salon Adı",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _nameControl,
                validator: (name) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(name));
                },
                maxLines: 1,
              ),//İsim
              SizedBox(height: 15.0),
              TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Ön Yazı",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _descriptionControl,
                validator: (surname) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(surname));
                },
                maxLines: 1,
              ),//Soyisim
              SizedBox(height: 15.0),
              TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "E-Posta",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _emailControl,
                validator: (email) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getEmailAdressControl(email));
                },
                maxLines: 1,
                keyboardType: TextInputType.emailAddress
              ),//E-Posta
              SizedBox(height: 15.0),
              TextFormField(
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    labelText: "Telefon Numarası (5XXXXXXXXX)",
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.blue,
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  controller: _phoneControl,
                  validator: (phoneNumber) {
                    return FormControlUtil.getErrorControl(FormControlUtil.getPhoneNumberControl(phoneNumber));
                  },
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
              ),
              SizedBox(height: 15.0),
              TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Adres",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _addresControl,
                validator: (userName) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(userName));
                },
                maxLines: 1,
              ),//Kullanıcı Adı
              SizedBox(height: 15.0),
              GestureDetector(
                child: Card(
                  elevation: 3.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text(
                          "İl",
                          style: kStyle,
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsetsDirectional.fromSTEB(
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize),
                      ),
                      Text(
                        regionList[selectedRegion].name,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200.0,
                          child: CupertinoPicker(
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                SearchViewModel rm = SearchViewModel();
                                setState(() {
                                  selectedRegion = index;
                                  selectedDistrict = 0;
                                });
                              },
                              children: new List<Widget>.generate(
                                  regionList.length, (int index) {
                                return new Center(
                                  child: new Text(regionList[index].name),
                                );
                              })),
                        );
                      });
                },
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                child: Card(
                  elevation: 3.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text(
                          "İlçe",
                          style: kStyle,
                        ),
                        padding: EdgeInsetsDirectional.fromSTEB(
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize),
                      ),
                      Text(
                        districtList[selectedDistrict].name,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200.0,
                          child: CupertinoPicker(
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  selectedDistrict = index;
                                });
                              },
                              children: new List<Widget>.generate(
                                  districtList.length, (int index) {
                                return new Center(
                                  child: new Text(districtList[index].name),
                                );
                              })),
                        );
                      });
                },
              ),
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
                      CommonInformationsViewModel rvm = CommonInformationsViewModel();
                      rvm.customerUserRegisterFlow(
                        context,
                        _addresControl.text,
                        _nameControl.text,
                        _descriptionControl.text,
                        _phoneControl.text,
                        _emailControl.text,
                      );
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
