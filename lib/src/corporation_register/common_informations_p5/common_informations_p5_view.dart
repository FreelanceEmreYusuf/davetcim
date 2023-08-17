import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/corporation_registration_dto.dart';
import '../../../shared/enums/customer_role_enum.dart';
import '../../../shared/helpers/customer_helper.dart';
import '../../../shared/models/customer_model.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../common_informations_p6/common_informations_p6_view.dart';

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
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  final TextEditingController _phoneControl = new TextEditingController();
  final TextEditingController _nameControl = new TextEditingController();
  final TextEditingController _surnameControl = new TextEditingController();
  final TextEditingController _secretQuestionAnswerControl =
  new TextEditingController();
  static List<SecretQuestionsModel> secretQuestionList = [];
  SecretQuestionsModel selectedQuestion;
  final registerFormKey = GlobalKey <FormState> ();
  String formException = "";
  String usernameException = "";
  bool usernameExists = false;
  @override
  void initState() {
    callSecretQuestionList();
  }

  void callSecretQuestionList() async{
    RegisterViewModel rm = RegisterViewModel();
    secretQuestionList = await rm.fillQuestionList();

    setState(() {
      secretQuestionList = secretQuestionList;
    });
  }


  Future<String> getUsernameControl(String username) async {
    String errorMessage =
      FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(username));
    if (errorMessage.length > 0) {
      return errorMessage;
    }

    errorMessage = await CustomerHelper.getUserExistingControlWithUserName(username);
    return errorMessage;
  }


  @override
  Widget build(BuildContext contex){
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()  async {
          if (registerFormKey.currentState.validate()) {
            CustomerModel _customer = new CustomerModel(
                username: _usernameControl.text,
                id: new DateTime.now().millisecondsSinceEpoch,
                corporationId: 0,
                gsmNo: _phoneControl.text,
                isActive: true,
                name: _nameControl.text,
                password: _passwordControl.text,
                roleId: CustomerRoleEnum.organizationOwner,
                recordDate: Timestamp.now(),
                surname: _surnameControl.text,
                eMail: _emailControl.text,
                secretQuestionId: selectedQuestion.id,
                secretQuestionAnswer: _secretQuestionAnswerControl.text,
                notificationCount: 0,
                basketCount: 0);
            widget.corpReg.customerModel = _customer;

            String errorMessage = await CustomerHelper.getUserExistingControlWithUserName(_usernameControl.text);
            if (errorMessage.isNotEmpty) {
              setState(() {
                usernameExists= true;
              });
            } else {
              Utils.navigateToPage(context, CommonInformationsP6View(corpReg: widget.corpReg,));
            }
          }
        },
        label: const Text('Devam Et'),
        icon: const Icon(Icons.navigate_next),
        backgroundColor: Colors.redAccent,
      ),
      appBar: AppBarMenu(pageName: "Salon Admin Hesabı Oluştur", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body:
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: Form(
          key: registerFormKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
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
                controller: _surnameControl,
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
                controller: _usernameControl,
                validator: (userName)  {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(userName));
                },
                maxLines: 1,
              ),
              Visibility(
                  visible: usernameExists,
                  child: Container(
                      child: Text("Girilen Kullanıcı Adı Mevcut", style: TextStyle(color: Colors.red)),
                      padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
                  )),//Kullanıcı Adı
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
                controller: _passwordControl,
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
                controller: _secretQuestionAnswerControl,
                validator: (secretQuestionAnswer) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(secretQuestionAnswer));
                },
                maxLines: 1,
              ),//Cevap

            ],
          ),
        ),
      ),
    );
  }
}
