import 'package:davetcim/screens/home.dart';
import 'package:davetcim/screens/main_screen.dart';
import 'package:davetcim/shared/extentions/form_control_extention.dart';
import 'package:davetcim/src/join/forgotPasswd/forgot_passwd_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  FormControlExtention formControlExtention = FormControlExtention();

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: Form(
          key: loginFormKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 25.0,
                ),
                child: Text(
                  "Hesabına Giriş Yap",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
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
                validator: (userName) {
                  if (formControlExtention.getNullControl(userName).isEmpty &&
                      formControlExtention
                          .getValueBetween3and70Control(userName)
                          .isEmpty)
                    return null;
                  else {
                    if (!formControlExtention.getNullControl(userName).isEmpty)
                      return formControlExtention.getNullControl(userName);
                    return formControlExtention
                        .getValueBetween3and70Control(userName);
                  }
                },
                maxLines: 1,
              ),
              SizedBox(height: 30.0),
              TextFormField(
                obscureText: true,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: "Şifre",
                  focusColor: Colors.blue,
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.lock_outline,
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
                validator: (password) {
                  if (formControlExtention.getPasswordControl(password).isEmpty)
                    return null;
                  else
                    return formControlExtention.getPasswordControl(password);
                },
                maxLines: 1,
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Text(
                    "Şifremi Unuttum",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ForgotPasswdView();
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                height: 50.0,
                child: RaisedButton(
                  child: Text(
                    "GİRİŞ".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    LoginViewModel vm = LoginViewModel();
                    if (loginFormKey.currentState.validate()) {
                      await vm.userLoginFlow(context, MainScreen(),
                          _usernameControl.text, _passwordControl.text);
                      // use the email provided here
                    }
                  },
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
