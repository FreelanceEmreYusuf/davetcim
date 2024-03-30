import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../user_register/company_user_register_view_model.dart';

class CorporationAddView extends StatefulWidget {
  @override
  _CorporationAddViewState createState() => _CorporationAddViewState();
}

class _CorporationAddViewState extends State<CorporationAddView> {
  final TextEditingController corporationNameControl = new TextEditingController();
  final TextEditingController addressControl = new TextEditingController();
  final TextEditingController emailControl = new TextEditingController();
  final TextEditingController passwordControl = new TextEditingController();
  final TextEditingController phoneControl = new TextEditingController();
  final TextEditingController surnameControl = new TextEditingController();
  final TextEditingController secretQuestionAnswerControl =
  new TextEditingController();
  static List<SecretQuestionsModel> secretQuestionList = [];
  SecretQuestionsModel selectedQuestion;
  final registerFormKey = GlobalKey <FormState> ();
  String formException = "";
  @override
  void initState() {
  }


  @override
  Widget build(BuildContext contex){
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
                child: Expanded(
                  child: Text(
                    "Yeni Salon Oluştur",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor,
                    ),
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
                  labelText: "Firma Adı",
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
                controller: corporationNameControl,
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
                controller: addressControl,
                validator: (userName) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(userName));
                },
                maxLines: 1,
              ),//Address
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
                controller: phoneControl,
                validator: (phoneNumber) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getPhoneNumberControl(phoneNumber));
                },
                maxLines: 1,
                keyboardType: TextInputType.number,
                maxLength: 10,
              ),//Telefon Numarası
              SizedBox(height: 12.0),

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
                  controller: emailControl,
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
                  labelText: "Şifre",
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
                controller: passwordControl,
                validator: (passwordControl) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getPasswordControl(passwordControl));
                },
                obscureText: true,
                maxLines: 1,
              ),//Şifre
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
                  onPressed: () {
                    if (registerFormKey.currentState.validate()) {
                      CompanyUserRegisterViewModel rvm = CompanyUserRegisterViewModel();
                      rvm.customerUserRegisterFlow(
                        context,
                        addressControl.text,
                        passwordControl.text,
                        corporationNameControl.text,
                        surnameControl.text,
                        phoneControl.text,
                        emailControl.text,
                        secretQuestionAnswerControl.text,
                        selectedQuestion,
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
}
