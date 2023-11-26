import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/sessions/application_cache.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/helpers/customer_helper.dart';
import 'company_user_register_view_model.dart';

class CompanyUserRegisterView extends StatefulWidget {
  @override
  _CompanyUserRegisterViewState createState() => _CompanyUserRegisterViewState();
}

class _CompanyUserRegisterViewState extends State<CompanyUserRegisterView> {
  final TextEditingController usernameControl = new TextEditingController();
  final TextEditingController emailControl = new TextEditingController();
  final TextEditingController passwordControl = new TextEditingController();
  final TextEditingController phoneControl = new TextEditingController();
  final TextEditingController nameControl = new TextEditingController();
  final TextEditingController surnameControl = new TextEditingController();
  final TextEditingController secretQuestionAnswerControl =
      new TextEditingController();
  static List<SecretQuestionsModel> secretQuestionList = [];
  SecretQuestionsModel selectedQuestion;
  final registerFormKey = GlobalKey <FormState> ();
  String formException = "";

  bool usernameErrorVisibility = false;
  bool emailErrorVisibility = false;

  @override
  void initState() {
    fillDefinedAreas();
    callSecretQuestionList();
  }

  void fillDefinedAreas() async{
    emailControl.text = ApplicationCache.userCache.eMail;
    phoneControl.text = ApplicationCache.userCache.gsmNo;
    nameControl.text = ApplicationCache.userCache.name;
    surnameControl.text = ApplicationCache.userCache.surname;
  }

  void callSecretQuestionList() async{
    RegisterViewModel rm = RegisterViewModel();
    secretQuestionList = await rm.fillQuestionList();

    setState(() {
      secretQuestionList = secretQuestionList;
    });
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
                child: Text(
                  "Yeni Hesap Oluştur",
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
                  labelText: "İsim",
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
                controller: nameControl,
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
                  labelText: "Soyisim",
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
                controller: surnameControl,
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
                  labelText: "Kullanıcı Adı",
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
                controller: usernameControl,
                validator: (userName) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(userName));
                },
                maxLines: 1,
              ),
              Visibility(
                  visible: usernameErrorVisibility,
                  child: Container(
                      child: Text("Bu kullanıcı adı sistemde kullanılıyor", style: TextStyle(color: Colors.red)),
                      padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
                  )),//Kullanıcı Adı//Kullanıcı Adı
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
                controller: emailControl,
                validator: (email) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getEmailAdressControl(email));
                },
                maxLines: 1,
                keyboardType: TextInputType.emailAddress
              ),
              Visibility(
                  visible: emailErrorVisibility,
                  child: Container(
                      child: Text("Bu email bilgisi sistemde kullanılıyor", style: TextStyle(color: Colors.red)),
                      padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
                  )),//E-Posta//E-Posta
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
              DropdownButtonFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Gizli Soru",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.security,
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
                value: selectedQuestion,
                onChanged: (SecretQuestionsModel newValue) {
                  setState(() {
                    selectedQuestion = newValue;
                  });
                },
                items: secretQuestionList.map((SecretQuestionsModel question) {
                  return new DropdownMenuItem<SecretQuestionsModel>(
                    value: question,
                    child: new Text(
                      question.questionText,
                      style: new TextStyle(color: Colors.black),
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
              TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Cevap",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.question_answer,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: secretQuestionAnswerControl,
                validator: (secretQuestionAnswer) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(secretQuestionAnswer));
                },
                maxLines: 1,
              ),//Cevap
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
                      String userExistControlWithUserName =
                          await CustomerHelper.getUserExistingControlWithUserName(usernameControl.text);
                      String userExistControlWithEmail =
                          await CustomerHelper.getUserExistingControlWithEmail(emailControl.text);
                      if (userExistControlWithUserName.isNotEmpty && userExistControlWithEmail.isNotEmpty) {
                        setState(() {
                          usernameErrorVisibility = true;
                          emailErrorVisibility = true;
                        });
                      } else if (userExistControlWithUserName.isNotEmpty) {
                        setState(() {
                          usernameErrorVisibility = true;
                        });
                      } else if (userExistControlWithEmail.isNotEmpty) {
                        setState(() {
                          emailErrorVisibility = true;
                        });
                      } else {
                        CompanyUserRegisterViewModel rvm = CompanyUserRegisterViewModel();
                        rvm.customerUserRegisterFlow(
                          context,
                          usernameControl.text,
                          passwordControl.text,
                          nameControl.text,
                          surnameControl.text,
                          phoneControl.text,
                          emailControl.text,
                          secretQuestionAnswerControl.text,
                          selectedQuestion,
                        );
                      }
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
