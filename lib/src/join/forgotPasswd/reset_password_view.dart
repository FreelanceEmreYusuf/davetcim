import 'package:flutter/material.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/join/forgotPasswd/reset_password_view_model.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/utils.dart';

class ResetPasswordView extends StatefulWidget {
  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final forgotPasswordForm = GlobalKey<FormState>();
  final TextEditingController _usernameControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();
  final TextEditingController _passwordAgainControl = TextEditingController();
  final TextEditingController _secretQuestionControl = TextEditingController();

  static List<SecretQuestionsModel> secretQuestionList = [];
  SecretQuestionsModel selectedQuestion;

  bool usernameErrorVisibility = false;
  bool obscurePassword = true; // To toggle password visibility

  @override
  void initState() {
    callSecretQuestionList();
    super.initState();
  }

  void callSecretQuestionList() async {
    ResetPasswdViewModel fp = ResetPasswdViewModel();
    secretQuestionList = await fp.fillQuestionList();
    setState(() {
      secretQuestionList = secretQuestionList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
      child: Form(
        key: forgotPasswordForm,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 25.0),
              child: Text(
                "Şifreyi Yenile",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Kullanıcı Adı",
                prefixIcon: Icon(Icons.person),
              ),
              controller: _usernameControl,
              validator: (name) => FormControlUtil.getErrorControl(
                FormControlUtil.getDefaultFormValueControl(name),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "E-Posta",
                prefixIcon: Icon(Icons.mail_outline),
              ),
              controller: _emailControl,
              validator: (email) => FormControlUtil.getErrorControl(
                FormControlUtil.getDefaultFormValueControl(email),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Yeni Parola",
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
              ),
              controller: _passwordControl,
              validator: (password) => FormControlUtil.getErrorControl(
                FormControlUtil.getPasswordCompareControl(
                  password,
                  _passwordAgainControl.text,
                ),
              ),
              obscureText: obscurePassword,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Yeni Parola Tekrar",
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
              ),
              controller: _passwordAgainControl,
              validator: (password) => FormControlUtil.getErrorControl(
                FormControlUtil.getPasswordCompareControl(
                  _passwordControl.text,
                  password,
                ),
              ),
              obscureText: obscurePassword,
            ),
            SizedBox(height: 20.0),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: "Gizli Soru",
                prefixIcon: Icon(Icons.security),
              ),
              isExpanded: true,
              value: selectedQuestion,
              onChanged: (newValue) {
                setState(() {
                  selectedQuestion = newValue;
                });
              },
              items: secretQuestionList.map((question) {
                return DropdownMenuItem<SecretQuestionsModel>(
                  value: question,
                  child: Text(question.questionText),
                );
              }).toList(),
              validator: (selectedQuestionValue) {
                return selectedQuestionValue == null
                    ? FormControlUtil.getErrorControl(
                  LanguageConstants.formElementNullValueMessage[
                  LanguageConstants.languageFlag],
                )
                    : null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Cevap",
                prefixIcon: Icon(Icons.question_answer),
              ),
              controller: _secretQuestionControl,
              validator: (answer) => FormControlUtil.getErrorControl(
                FormControlUtil.getDefaultFormValueControl(answer),
              ),
            ),
            SizedBox(height: 20.0),
            Visibility(
              visible: usernameErrorVisibility,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Girdiğiniz bilgiler doğrulanamadı",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                ),
                onPressed: () async {
                  if (forgotPasswordForm.currentState.validate()) {
                    ResetPasswdViewModel rpvm = ResetPasswdViewModel();
                    bool isRegistered =
                    await rpvm.userResetPasswordFlow(
                      context,
                      _usernameControl.text,
                      _emailControl.text,
                      _passwordControl.text,
                      selectedQuestion.id,
                      _secretQuestionControl.text,
                    );

                    if (!isRegistered) {
                      setState(() {
                        usernameErrorVisibility = true;
                      });
                    }
                  }
                },
                child: Text(
                  "Parolayı Yenile".toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  static void pushToJoinPage(BuildContext context) {
    Utils.navigateToPage(context, JoinView());
  }
}
