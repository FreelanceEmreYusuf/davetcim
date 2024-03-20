import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/helpers/customer_helper.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _usernameControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();
  final TextEditingController _phoneControl = TextEditingController();
  final TextEditingController _nameControl = TextEditingController();
  final TextEditingController _surnameControl = TextEditingController();
  final TextEditingController _secretQuestionAnswerControl = TextEditingController();
  static List<SecretQuestionsModel> secretQuestionList = [];
  SecretQuestionsModel selectedQuestion;
  final registerFormKey = GlobalKey<FormState>();
  String formException = "";
  bool usernameErrorVisibility = false;
  bool emailErrorVisibility = false;

  @override
  void initState() {
    super.initState();
    callSecretQuestionList();
  }

  void callSecretQuestionList() async {
    RegisterViewModel rm = RegisterViewModel();
    secretQuestionList = await rm.fillQuestionList();
    setState(() {
      secretQuestionList = secretQuestionList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: registerFormKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 30.0),
              Text(
                "Yeni Hesap Oluştur",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "İsim",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                controller: _nameControl,
                validator: (name) {
                  return FormControlUtil.getErrorControl(
                      FormControlUtil.getStringLenghtBetweenMinandMaxControl(name, 3, 15));
                },
              ),
              SizedBox(height: 15.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Soyisim",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                controller: _surnameControl,
                validator: (surname) {
                  return FormControlUtil.getErrorControl(
                      FormControlUtil.getStringLenghtBetweenMinandMaxControl(surname, 2, 15));
                },
              ),
              SizedBox(height: 15.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Kullanıcı Adı",
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                ),
                controller: _usernameControl,
                validator: (userName) {
                  return FormControlUtil.getErrorControl(
                      FormControlUtil.getStringLenghtBetweenMinandMaxControl(userName, 3, 15));
                },
              ),
              Visibility(
                visible: usernameErrorVisibility,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Bu kullanıcı adı sistemde kullanılıyor",
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "E-Posta",
                  prefixIcon: Icon(Icons.mail_outline),
                  border: OutlineInputBorder(),
                ),
                controller: _emailControl,
                validator: (email) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getEmailAdressControl(email));
                },
                keyboardType: TextInputType.emailAddress,
              ),
              Visibility(
                visible: emailErrorVisibility,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Bu email bilgisi sistemde kullanılıyor",
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Telefon Numarası",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                controller: _phoneControl,
                validator: (phoneNumber) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getPhoneNumberControl(phoneNumber));
                },
                keyboardType: TextInputType.phone,
                maxLength: 10,
              ),
              SizedBox(height: 15.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Şifre",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                controller: _passwordControl,
                validator: (passwordControl) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getPasswordControl(passwordControl));
                },
                obscureText: true,
              ),
              SizedBox(height: 15.0),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "Gizli Soru",
                  prefixIcon: Icon(Icons.security),
                  border: OutlineInputBorder(),
                ),
                isExpanded: true,
                value: selectedQuestion,
                onChanged: (SecretQuestionsModel newValue) {
                  setState(() {
                    selectedQuestion = newValue;
                  });
                },
                items: secretQuestionList.map((SecretQuestionsModel question) {
                  return DropdownMenuItem<SecretQuestionsModel>(
                    value: question,
                    child: Text(
                      question.questionText,
                      style: TextStyle(color: Colors.blue),
                    ),
                  );
                }).toList(),
                validator: (selectedQuestionValue) {
                  if (selectedQuestionValue == null) {
                    return FormControlUtil.getErrorControl(
                        LanguageConstants.formElementNullValueMessage[LanguageConstants.languageFlag]);
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 15.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Cevap",
                  prefixIcon
                      : Icon(Icons.question_answer),
                  border: OutlineInputBorder(),
                ),
                controller: _secretQuestionAnswerControl,
                validator: (secretQuestionAnswer) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(secretQuestionAnswer));
                },
              ),
              SizedBox(height: 15.0),
              Container(
                height: 40.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () async {
                    if (registerFormKey.currentState.validate()) {
                      String userExistControlWithUserName = await CustomerHelper.getUserExistingControlWithUserName(_usernameControl.text);
                      String userExistControlWithEmail = await CustomerHelper.getUserExistingControlWithEmail(_emailControl.text);
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
                        RegisterViewModel rvm = RegisterViewModel();
                        rvm.customerUserRegisterFlow(
                          context,
                          _usernameControl.text,
                          _passwordControl.text,
                          _nameControl.text,
                          _surnameControl.text,
                          _phoneControl.text,
                          _emailControl.text,
                          _secretQuestionAnswerControl.text,
                          selectedQuestion,
                        );
                      }
                    }
                  },
                  child: Text(
                    "Kaydet".toUpperCase(),
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
