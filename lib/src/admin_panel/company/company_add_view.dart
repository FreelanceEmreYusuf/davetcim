import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/helpers/customer_helper.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import 'company_view_model.dart';

class CompanyAddView extends StatefulWidget {
  @override
  _CompanyAddViewState createState() => _CompanyAddViewState();
}

class _CompanyAddViewState extends State<CompanyAddView> {
  final TextEditingController firmNameControl = new TextEditingController();
  final TextEditingController usernameControl = new TextEditingController();
  final TextEditingController emailControl = new TextEditingController();
  final TextEditingController passwordControl = new TextEditingController();
  final TextEditingController phoneControl = new TextEditingController();
  final TextEditingController nameControl = new TextEditingController();
  final TextEditingController surnameControl = new TextEditingController();

  final registerFormKey = GlobalKey <FormState> ();
  String formException = "";

  bool usernameErrorVisibility = false;
  bool emailErrorVisibility = false;

  @override
  Widget build(BuildContext contex){
    return Scaffold(
      appBar: AppBarMenu(pageName: "Yeni Firma Ekle", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body:
      Container(
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
                TextFormField(
                  style: TextStyle(
                    fontSize: 15.0,
                    //color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    labelText: "Firma İsmi",
                    filled: true,
                    //fillColor: Colors.white,
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
                  controller: firmNameControl,
                  validator: (name) {
                    return FormControlUtil.getErrorControl(
                        FormControlUtil.getStringLenghtBetweenMinandMaxControl(name, 3, 15));
                  },
                  maxLines: 1,
                ),//Firma İsimi
                SizedBox(height: 15.0),
                TextFormField(
                  style: TextStyle(
                    fontSize: 15.0,
                    //color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    labelText: "İsim",
                    filled: true,
                    //fillColor: Colors.white,
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
                    return FormControlUtil.getErrorControl(
                        FormControlUtil.getStringLenghtBetweenMinandMaxControl(name, 3, 15));
                  },
                  maxLines: 1,
                ),//İsim
                SizedBox(height: 15.0),
                TextFormField(
                  style: TextStyle(
                    fontSize: 15.0,
                    //color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    labelText: "Soyisim",
                    filled: true,
                    //fillColor: Colors.white,
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
                    return FormControlUtil.getErrorControl(
                        FormControlUtil.getStringLenghtBetweenMinandMaxControl(surname, 2, 15));
                  },
                  maxLines: 1,
                ),//Soyisim
                SizedBox(height: 15.0),
                TextFormField(
                  style: TextStyle(
                    fontSize: 15.0,
                    //color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    labelText: "Kullanıcı Adı",
                    filled: true,
                    //fillColor: Colors.white,
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
                    return FormControlUtil.getErrorControl(
                        FormControlUtil.getStringLenghtBetweenMinandMaxControl(userName, 3, 15));
                  },
                  maxLines: 1,
                ),
                Visibility(
                    visible: usernameErrorVisibility,
                    child: Container(
                        child: Expanded(child: Text("Bu kullanıcı adı sistemde kullanılıyor", style: TextStyle(color: Colors.red))),
                        padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
                    )),//Kullanıcı Adı//Kullanıcı Adı//Kullanıcı Adı
                SizedBox(height: 15.0),
                TextFormField(
                    style: TextStyle(
                      fontSize: 15.0,
                      //color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                      labelText: "E-Posta",
                      filled: true,
                      //fillColor: Colors.white,
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
                        child: Expanded(child: Text("Bu email bilgisi sistemde kullanılıyor", style: TextStyle(color: Colors.red))),
                        padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 25))
                    )),//E-Posta//E-Posta//E-Posta
                SizedBox(height: 15.0),
                TextFormField(
                  style: TextStyle(
                    fontSize: 15.0,
                    //color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    labelText: "Telefon Numarası (5XXXXXXXXX)",
                    filled: true,
                    //fillColor: Colors.white,
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
                    //color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    labelText: "Şifre",
                    filled: true,
                    //fillColor: Colors.white,
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
                          CompanyViewModel cvm = CompanyViewModel();
                          cvm.companyAddRegisterFlow(
                            context,
                            firmNameControl.text,
                            usernameControl.text,
                            passwordControl.text,
                            nameControl.text,
                            surnameControl.text,
                            phoneControl.text,
                            emailControl.text,
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
      ),
    );
  }
}
