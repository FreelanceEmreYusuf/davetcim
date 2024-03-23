import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/sessions/corporation_registration_dto.dart';
import '../../../shared/models/company_model.dart';
import '../../../shared/models/corporation_model.dart';
import '../../../shared/models/region_model.dart';
import '../../../shared/sessions/application_context.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../search/search_view_model.dart';
import '../common_informations_p2/common_informations_p2_view.dart';

class CommonInformationsP1View extends StatefulWidget {
  @override
  _CommonInformationsP1ViewState createState() => _CommonInformationsP1ViewState();
  final CompanyModel companyModel;
  final int registrationKey;

  CommonInformationsP1View(
      {Key key,
        @required this.companyModel,
        @required this.registrationKey,
       })
      : super(key: key);
}

class _CommonInformationsP1ViewState extends State<CommonInformationsP1View> {
  final TextEditingController _firmNameControl = new TextEditingController();
  final TextEditingController _addresControl = new TextEditingController();
  final TextEditingController _latitudeControl = new TextEditingController();
  final TextEditingController _longitudeControl = new TextEditingController();
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _phoneControl = new TextEditingController();
  final TextEditingController _nameControl = new TextEditingController();
  final TextEditingController _descriptionControl = new TextEditingController();
  final TextEditingController _maxPopulationControl = new TextEditingController();
  final TextEditingController _minReservationAmount = new TextEditingController();
  final TextEditingController _minReservationAmountWeekend = new TextEditingController();
  final registerFormKey = GlobalKey <FormState> ();
  String formException = "";
  int _cardDivisionSize = 20;
  static TextStyle kStyle =
  TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);
  List<RegionModel> regionList =
      ApplicationContext.filterCache.regionModelList;
  int selectedRegion = 0;
  int selectedDistrict = 0;
  @override
  void initState() {
    _firmNameControl.text = widget.companyModel.name;
    firstInitialDistrict();
  }

  void firstInitialDistrict() async {
    if (regionList != null && regionList.length > 0) {
      SearchViewModel rm = SearchViewModel();
      districtList = await rm.fillDistrictlist(regionList[0].id);
    } else {
      firstInitialDistrict();
    }
  }

  @override
  Widget build(BuildContext contex){
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
                  color: Colors.black54,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Firma Adı",
                  enabled: false,
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.business,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _firmNameControl,
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
                  labelText: "Salon Adı",
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
                    Icons.text_fields,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _descriptionControl,
                validator: (description) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControlMax200(description));
                },
                maxLines: 1,
                maxLength: 200,
              ),//ön yazı
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
                    color: Colors.black54,
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
                      Icons.phone,
                      color: Colors.black54,
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
                  labelText: "Maximum Kapasite",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.person_add,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _maxPopulationControl,
                validator: (maxPopulation) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControlBetweenMinMax(maxPopulation,1,6));
                },
                maxLines: 1,
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
              SizedBox(height: 15.0),

              TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Min Rezervasyon Tutarı (Haftaiçi)",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.person_add,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _minReservationAmount,
                validator: (minReservationAmount) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControlBetweenMinMax(minReservationAmount,1,6));
                },
                maxLines: 1,
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
              SizedBox(height: 15.0),
              TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Min Rezervasyon Tutarı(Haftasonu)",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.person_add,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _minReservationAmountWeekend,
                validator: (minReservationAmount) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControlBetweenMinMax(minReservationAmount,1,6));
                },
                maxLines: 1,
                keyboardType: TextInputType.number,
                maxLength: 6,
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
                    Icons.home_work_sharp,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _addresControl,
                validator: (address) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControlMax200(address));
                },
                maxLines: 1,
                maxLength: 200,
              ),//address
              SizedBox(height: 15.0),
              TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Enlem Bilgisi",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.home_work_sharp,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _latitudeControl,
                validator: (latitude) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControlMax200(latitude));
                },
                maxLines: 1,
                maxLength: 200,
              ),//latitude
              SizedBox(height: 15.0),
              TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Boylam Bilgisi",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.home_work_sharp,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _longitudeControl,
                validator: (longitude) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControlMax200(longitude));
                },
                maxLines: 1,
                maxLength: 200,
              ),//latitude
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context, regionList[selectedRegion]); // Seçilen öğeyi geri döndürür
                          },
                          child: Container(
                            height: 200.0,
                            child: CupertinoPicker(
                                itemExtent: 32.0,
                                onSelectedItemChanged: (int index) async {
                                  SearchViewModel rm = SearchViewModel();
                                  districtList = await rm.fillDistrictlist(regionList[index].id);
                                  setState(() {
                                    selectedRegion = index;
                                    districtList = districtList;
                                    selectedDistrict = 0;
                                  });
                                },
                                children: new List<Widget>.generate(
                                    regionList.length, (int index) {
                                  return new Center(
                                    child: new Text(regionList[index].name),
                                  );
                                })),
                          ),
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context, districtList[selectedDistrict]); // Seçilen öğeyi geri döndürür
                          },
                          child: Container(
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
                          ),
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
                      CorporationModel corporation = new CorporationModel(
                          corporationId: new DateTime.now().millisecondsSinceEpoch,
                          corporationName: _nameControl.text,
                          address: _addresControl.text,
                          latitude: double.parse(_latitudeControl.text),
                          longitude: double.parse(_longitudeControl.text),
                          telephoneNo: _phoneControl.text,
                          email: _emailControl.text,
                          description: _descriptionControl.text,
                          region: regionList[selectedRegion].id.toString(),
                          district: districtList[selectedDistrict].id.toString(),
                          companyId: widget.companyModel.id,
                          maxPopulation: int.parse(_maxPopulationControl.text),
                          minReservationAmount: int.parse(_minReservationAmount.text),
                          minReservationAmountWeekend: int.parse(_minReservationAmountWeekend.text),
                          ratingCount: 0,
                          recordDate: Timestamp.now(),
                          averageRating: 0,
                          imageUrl: "",
                          isPopularCorporation: false,
                          isActive: true);
                      ApplicationContext.corporationReservation = new CorporationReservationDto(
                        widget.companyModel, corporation, null,
                        regionList[selectedRegion].name, districtList[selectedDistrict].name,
                        "", "", "", "", widget.registrationKey);

                      Utils.navigateToPage(context, CommonInformationsP2View());
                      //Utils.navigateToPage(context, CheckBoxListItem());
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
}
