import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/company_model.dart';
import '../../../shared/utils/utils.dart';
import '../../corporation_register/common_informations_p1/common_informations_p1_view.dart';
import 'corporation_register_view_model.dart';

class CorporationRegisterView extends StatefulWidget {
  @override
  _CorporationRegisterViewState createState() =>
      _CorporationRegisterViewState();
}

class _CorporationRegisterViewState extends State<CorporationRegisterView> {
  final TextEditingController _activationKeyControl =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _keyErrorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 25.0),
                child: Text(
                  "Salonunu Kaydet",
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
                ),
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Salon aktivasyon kodunuzu girin",
                  filled: true,
                  fillColor: Colors.transparent,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.key,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: _activationKeyControl,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Lütfen bir anahtar değeri girin";
                  }
                  return null;
                },
                maxLines: 1,
              ),
              SizedBox(height: 15.0),
              Visibility(
                visible: _keyErrorVisibility,
                child: Container(
                  child: Text(
                    "Girilen Anahtar Değeri Bulunamadı",
                    style: TextStyle(color: Colors.red),
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                height: 40.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      CorporationRegisterViewModel corporationRegisterViewModel =
                      CorporationRegisterViewModel();
                      CompanyModel companyModel =
                      await corporationRegisterViewModel.getCompanyForKey(
                          int.parse(_activationKeyControl.text));
                      if (companyModel == null) {
                        setState(() {
                          _keyErrorVisibility = true;
                        });
                      } else {
                        Utils.navigateToPage(
                          context,
                          CommonInformationsP1View(
                            companyModel: companyModel,
                            registrationKey: int.parse(
                                _activationKeyControl.text),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    "ONAYLA".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
