import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/corporation_organizations_response_dto.dart';
import '../../../shared/models/company_model.dart';
import '../../../shared/models/corporation_model.dart';
import '../../../shared/models/region_model.dart';
import '../../../shared/utils/form_control.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../admin_panel/company/company_view_model.dart';
import '../../search/search_view_model.dart';
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

  final TextEditingController _firmNameControl = new TextEditingController();
  final TextEditingController _addresControl = new TextEditingController();
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _phoneControl = new TextEditingController();
  final TextEditingController _nameControl = new TextEditingController();
  final TextEditingController _descriptionControl = new TextEditingController();
  final TextEditingController _maxPopulationControl = new TextEditingController();

  final registerFormKey = GlobalKey <FormState> ();
  final registerFormKey2 = GlobalKey <FormState> ();
  final registerFormKey3 = GlobalKey <FormState> ();

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
    fillCorporateInfo();
    callGetOrganizationTypes();
  }

  void fillCorporateInfo() async {
    CorporateHelper corporateHelper = CorporateHelper();
    CorporationModel corporationModel =  await corporateHelper.getCorporate(ApplicationSession.userSession.corporationId);
    CompanyViewModel cvm = CompanyViewModel();
    CompanyModel companyModel = await cvm.getById(corporationModel.companyId);
    _firmNameControl.text = companyModel.name;
    _nameControl.text = corporationModel.corporationName;
    _addresControl.text = corporationModel.address;
    _emailControl.text = corporationModel.email;
    _phoneControl.text = corporationModel.telephoneNo;
    _descriptionControl.text = corporationModel.description;
    _maxPopulationControl.text = corporationModel.maxPopulation.toString();

    for (int i = 0; i < regionList.length; i++) {
      if (regionList[i].id == int.parse(corporationModel.region)) {
        selectedRegion = i;
        break;
      }
    }

    SearchViewModel rm = SearchViewModel();
    districtList = await rm.fillDistrictlist(regionList[selectedRegion].id);

    for (int i = 0; i < districtList.length; i++) {
      if (districtList[i].id == int.parse(corporationModel.district)) {
        setState(() {
          selectedRegion = selectedRegion;
          selectedDistrict = i;
        });
        break;
      }
    }
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
    onPressed: () async {
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
        CorporateHelper corporateHelper = CorporateHelper();
        CorporationModel corporationModel =  await corporateHelper.getCorporate(ApplicationSession.userSession.corporationId);
        corporationModel.corporationName = _nameControl.text;
        corporationModel.address = _addresControl.text;
        corporationModel.telephoneNo = _phoneControl.text;
        corporationModel.email = _emailControl.text;
        corporationModel.description = _descriptionControl.text;
        corporationModel.region = regionList[selectedRegion].id.toString();
        corporationModel.district = districtList[selectedDistrict].id.toString();
        corporationModel.maxPopulation = int.parse(_maxPopulationControl.text);
        corporationModel.organizationUniqueIdentifier = organizationUniqueIdentifier;
        corporationModel.invitationUniqueIdentifier = invitationUniqueIdentifier;
        corporationModel.sequenceOrderUniqueIdentifier = sequenceOrderIdentifier;

        CorporationCommonPropertiesEditViewModel viewModel = CorporationCommonPropertiesEditViewModel();
        viewModel.setCorporationInfoAndOrganizationTypes(corporationModel);
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
            Container(
              padding: const EdgeInsets.only(left: 14.0, top: 14.0),
              child: Text("Salon Tanımları",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
              ),
            ),
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
              maxLength: 1000,
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
