import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_provider.dart';
import '../../../shared/environments/const.dart';
import '../../../shared/models/company_model.dart';
import '../../../shared/utils/language.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import 'corporation_generate_key_view_model.dart';

class CorporationGenerateKeyView extends StatefulWidget {
  @override
  _CorporationGenerateKeyViewState createState() => _CorporationGenerateKeyViewState();
}

class _CorporationGenerateKeyViewState extends State<CorporationGenerateKeyView> {
  static List<CompanyModel> companyList = [];
  CompanyModel selectedCompany;

  final registerFormKey = GlobalKey <FormState> ();
  String formException = "";
  int keyNumber = 0;
  bool keyVisibility = false;

  @override
  void initState() {
    callCompanyList();
  }

  void callCompanyList() async{
    CorporationGenerateKeyViewModel rm = CorporationGenerateKeyViewModel();
    companyList = await rm.fillCompanyList();

    setState(() {
      companyList = companyList;
    });
  }

  @override
  Widget build(BuildContext contex){
    return Scaffold(
      appBar: AppBarMenu(pageName: "Yeni Salon Ekle", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body:Container(
        height: MediaQuery.of(context).size.height ,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors:[Color.fromRGBO(233, 211, 98, 1.0),Color.fromARGB(203, 173, 109, 99),Color.fromARGB(51, 51, 51, 1),]
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
          child: Form(
            key: registerFormKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 30.0),
                DropdownButtonFormField(
                  dropdownColor: Colors.white70,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    labelText: "Firma Seçiniz",
                    filled: true,
                    //fillColor: Colors.white,
                    focusColor: Colors.blue,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  value: selectedCompany,
                  onChanged: (CompanyModel newValue) {
                    setState(() {
                      selectedCompany = newValue;
                    });
                  },
                  items: companyList.map((CompanyModel company) {
                    return new DropdownMenuItem<CompanyModel>(
                      value: company,
                      child: FittedBox(
                        child: new Text(
                          company.name,
                          style: new TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }).toList(),
                  validator: (selectedQuestionValue){
                    if(selectedQuestionValue == null)
                    {
                      return FormControlUtil.getErrorControl(LanguageConstants.formElementNullValueMessage[LanguageConstants.languageFlag]);
                    }
                    else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 15.0),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 4.0),
                  height: 40.0,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.redAccent,),
                    child: Text(
                      "Kaydet".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (registerFormKey.currentState.validate()) {
                        CorporationGenerateKeyViewModel cvm = CorporationGenerateKeyViewModel();
                        keyNumber = await cvm.createCorporationRegistrationKey(
                            selectedCompany.id
                        );

                        setState(() {
                          keyNumber = keyNumber;
                          keyVisibility = true;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 30),
                Visibility(
                    visible: keyVisibility,
                    child: Container(
                        child: Center(child: FittedBox(
                          child: Expanded(
                            child: Text("Salon Kayıt İşlemi için Üretilen Key", style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,),),
                          ),
                        )),
                        padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
                    )),
                Visibility(
                    visible: keyVisibility,
                    child: Container(
                        child: MaterialButton(
                          elevation: 10.0,
                          splashColor: Colors.green,
                          onPressed: () {
                            Clipboard.setData( ClipboardData(text: keyNumber.toString())).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Expanded(child: Text(keyNumber.toString()+" değeri başarı ile kopyalandı."))));
                            });
                          },
                          color: Colors.black45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.copy,
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Text(
                                  keyNumber.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}