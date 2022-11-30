import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/join/forgotPasswd/reset_password_view_model.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatefulWidget {
  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final forgotPasswordForm = GlobalKey <FormState> ();
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  final TextEditingController _passwordAgainControl =
      new TextEditingController();
  final TextEditingController _secretQuestionControl =
      new TextEditingController();

  static List<SecretQuestionsModel> secretQuestionList = [];
  SecretQuestionsModel selectedQuestion;

  @override
  void initState() {
    callSecretQuestionList();
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
          margin: EdgeInsets.only(
            top: 25.0,
          ),
          child: Text(
            "Şifreyi yenile",
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
          validator: (name) {
            return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(name));
          },
          maxLines: 1,
        ),
        SizedBox(height: 10.0),
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
            return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(email));
          },
          maxLines: 1,
        ),
        SizedBox(height: 10.0),
        TextFormField(
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            labelText: "Yeni Parola",
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.blue,
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
          validator: (email) {
            return FormControlUtil.getErrorControl(FormControlUtil.getPasswordCompareControl(_passwordControl.text, _passwordAgainControl.text));
          },
          maxLines: 1,
          obscureText: true,

        ),
        SizedBox(height: 10.0),
        TextFormField(
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            labelText: "Yeni Parola Tekrar",
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.blue,
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
          controller: _passwordAgainControl,
          validator: (email) {
            return FormControlUtil.getErrorControl(
                FormControlUtil.getPasswordCompareControl(
                    _passwordControl.text, _passwordAgainControl.text));
          },
          maxLines: 1,
          obscureText: true,

        ),
        SizedBox(height: 10.0),
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
        SizedBox(height: 10.0),
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
          controller: _secretQuestionControl,
          validator: (secretQuestionAnswer) {
            return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(secretQuestionAnswer));
          },
          maxLines: 1,
        ),//Cevap
        SizedBox(height: 40.0),
        Container(
          height: 50.0,
          child: TextButton(
            style: TextButton.styleFrom(backgroundColor: Theme.of(context).accentColor,),
            child: Text(
              "Parolayı Yenile".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              if (forgotPasswordForm.currentState.validate())
              {
                ResetPasswdViewModel rpvm = ResetPasswdViewModel();
                rpvm.userResetPasswordFlow(context,
                    _usernameControl.text,
                    _emailControl.text,
                    _passwordControl.text,
                    selectedQuestion.id,
                    _secretQuestionControl.text);
              }
            },
          ),
        ),
        SizedBox(height: 40.0),
        ],
      ),
      ),
    );
  }

  static void pushToJoinPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return JoinView();
        },
      ),
    );
  }
}
