import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/join/register/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CorporationRegisterView extends StatefulWidget {
  @override
  _CorporationRegisterViewState createState() => _CorporationRegisterViewState();
}

class _CorporationRegisterViewState extends State<CorporationRegisterView> {
  final TextEditingController _nameControl = new TextEditingController();
  final registerFormKey = GlobalKey <FormState> ();
  @override
  void initState() {
    //callSecretQuestionList();
  }

  /*void callSecretQuestionList() async{
    RegisterViewModel rm = RegisterViewModel();
    secretQuestionList = await rm.fillQuestionList();

    setState(() {
      secretQuestionList = secretQuestionList;
    });
  }*/


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
                  "Salon Kayıt Sayfası",
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
                  labelText: "Salon aktivasyon kodunuzu girin",
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.blue,
                  prefixIcon: Icon(
                    Icons.key,
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
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 4.0),
                height: 40.0,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.redAccent,),
                  child: Text(
                    "ONAYLA".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    //key kontrolü yapılacak değer doğru ise emrenin daha önceden yapmış olduğu salon akyıt sayfasına focuslanacak!
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
