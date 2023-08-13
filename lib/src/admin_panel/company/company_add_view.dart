import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:flutter/material.dart';

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
                  "Yeni Firma Oluştur",
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
                  labelText: "Firma İsmi",
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
                controller: firmNameControl,
                validator: (name) {
                  return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(name));
                },
                maxLines: 1,
              ),//Firma İsimi
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
