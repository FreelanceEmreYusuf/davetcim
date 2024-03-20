import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/src/home/home_view.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/src/join/forgotPasswd/forgot_passwd_view.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/utils.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  final Widget childPage;
  LoginView({
    Key key,
    this.childPage,
  }) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  bool loginErrorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: loginFormKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 30.0),
              Text(
                "Hesabına Giriş Yap",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0),
              TextFormField(
                style: TextStyle(
                  fontSize: 16.0,

                ),
                decoration: InputDecoration(
                  labelText: "Kullanıcı Adı",
                  prefixIcon: Icon(Icons.person, ),
                  border: OutlineInputBorder(),
                ),
                controller: _usernameControl,
                validator: (userName) {
                  return FormControlUtil.getErrorControl(
                      FormControlUtil.getDefaultFormValueControl(userName));
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                style: TextStyle(
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  labelText: "Şifre",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                controller: _passwordControl,
                validator: (password) {
                  return FormControlUtil.getErrorControl(
                      FormControlUtil.getPasswordControl(password));
                },
              ),
              Visibility(
                visible: loginErrorVisibility,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Kullanıcı adı ya da parolanız doğrulanamadı",
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Utils.navigateToPage(context, ForgotPasswdView());
                },
                child: Text(
                  "Şifremi Unuttum",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                onPressed: () async {
                  LoginViewModel vm = LoginViewModel();
                  if (loginFormKey.currentState.validate()) {
                    bool isRegistered = await vm.userLoginFlow(
                      context,
                      widget.childPage == null ? MainScreen() : widget.childPage,
                      _usernameControl.text,
                      _passwordControl.text,
                    );

                    if (!isRegistered) {
                      setState(() {
                        loginErrorVisibility = true;
                      });
                    }
                  }
                },
                child: Text(
                  "GİRİŞ".toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
