import 'package:davetcim/shared/helpers/customer_helper.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:davetcim/providers/app_provider.dart';
import 'package:davetcim/src/splash/splash_view.dart';
import 'package:davetcim/shared/environments/const.dart';

import '../../shared/utils/dialogs.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name;
  String surname;
  String gsmNo;
  String email;
  bool passwordWidget = false;

  @override
  void initState() {
    name = ApplicationSession.userSession.name;
    surname = ApplicationSession.userSession.surname;
    gsmNo = ApplicationSession.userSession.gsmNo;
    email = ApplicationSession.userSession.eMail;
    // TODO: implement initState
    super.initState();
  }

  void editCustomerName(String inputName) async {
    CustomerHelper customerHelper = CustomerHelper();
    await customerHelper.editCustomer(inputName, surname, email, gsmNo);
    setState(() {
      name = ApplicationSession.userSession.name;
    });
  }

  void editCustomerSurname(String inputSurname) async {
    CustomerHelper customerHelper = CustomerHelper();
    await customerHelper.editCustomer(name, inputSurname, email, gsmNo);
    setState(() {
      surname = ApplicationSession.userSession.surname;
    });
  }

  void editCustomerGSMNo(String inputGsm) async {
    CustomerHelper customerHelper = CustomerHelper();
    await customerHelper.editCustomer(name, surname, email, inputGsm);
    setState(() {
      gsmNo = ApplicationSession.userSession.gsmNo;
    });
  }

  void editCustomerEmail(String inputEmail) async {
    CustomerHelper customerHelper = CustomerHelper();
    await customerHelper.editCustomer(name, surname, inputEmail, gsmNo);
    setState(() {
      email = ApplicationSession.userSession.eMail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.redAccent,
                    size: MediaQuery.of(context).size.height / 6,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            ApplicationSession.userSession.username,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            ApplicationSession.userSession.eMail,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return SplashScreen();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Çıkış",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).accentColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  flex: 3,
                ),
              ],
            ),
            Divider(),
            Container(height: 15.0),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Kullanıcı Bilgileri".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Ad",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                name ,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: () {
                  Dialogs.showDialogMessageWithInputBox(context, "İsim Güncelle", "Vazgeç", "Onayla", name, 2, editCustomerName);
                },
                tooltip: "Ad Güncelle",
              ),
            ),
            ListTile(
              title: Text(
                "Soyad",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                surname,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: () {
                  Dialogs.showDialogMessageWithInputBox(context, "Soyisim Güncelle", "Vazgeç", "Onayla", surname, 2, editCustomerSurname);
                },
                tooltip: "Soyad Güncelle",
              ),
            ),
            ListTile(
              title: Text(
                "Email",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                email,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: () {
                  Dialogs.showDialogMessageWithInputBox(context, "Email Güncelle", "Vazgeç", "Onayla", email, 2, editCustomerEmail);
                },
                tooltip: "Email Güncelle",
              ),
            ),
            ListTile(
              title: Text(
                "Telefon Numarası",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                gsmNo,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: () {
                  Dialogs.showDialogMessageWithInputBox(context, "Telefon Güncelle", "Vazgeç", "Onayla", gsmNo, 2,  editCustomerGSMNo);
                },
                tooltip: "Telefon Numarası Güncelle",
              ),
            ),
            ListTile(
              title: Text(
                "Şifre Güncelle",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "Min 8 karakter",
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: () {
                  setState(() {
                    passwordWidget = !passwordWidget;
                  });
                  //Dialogs.showDialogMessageWithInputBox(context, "Telefon Güncelle", "Vazgeç", "Onayla", gsmNo, 2,  editCustomerGSMNo);
                },
                tooltip: "Şifre Değiştir",
              ),
            ),
            Visibility(
              visible: passwordWidget,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      color: Colors.redAccent),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: MediaQuery.of(context).size.height / 50,),
                        Card(
                          elevation: 10.0,
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                              labelText: "Eski Parola",
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
                            //controller: _nameControl,
                            /*validator: (name) {
                              return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(name));
                            },*/
                            maxLines: 1,
                          ),//İsim
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height / 50,),
                        Card(
                          elevation: 10.0,
                          child: TextFormField(
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
                            //controller: _nameControl,
                            /*validator: (name) {
                              return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(name));
                            },*/
                            maxLines: 1,
                          ),//İsim
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height / 50,),
                        Card(
                          elevation: 10.0,
                          child: TextFormField(
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
                            //controller: _nameControl,
                            /*validator: (name) {
                              return FormControlUtil.getErrorControl(FormControlUtil.getDefaultFormValueControl(name));
                            },*/
                            maxLines: 1,
                          ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height / 25,),
                        MaterialButton(
                          textColor: Colors.redAccent,
                          color: Colors.white,
                          child: Text('Güncelle'),
                          onPressed: () {

                          },
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),


            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? SizedBox()
                : ListTile(
                    title: Text(
                      "Gece Modu",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    trailing: Switch(
                      value: Provider.of<AppProvider>(context).theme ==
                              Constants.lightTheme
                          ? false
                          : true,
                      onChanged: (v) async {
                        if (v) {
                          Provider.of<AppProvider>(context, listen: false)
                              .setTheme(Constants.darkTheme, "dark");
                        } else {
                          Provider.of<AppProvider>(context, listen: false)
                              .setTheme(Constants.lightTheme, "light");
                        }
                      },
                      activeColor: Theme.of(context).accentColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
