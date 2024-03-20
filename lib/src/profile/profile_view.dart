import 'package:davetcim/shared/helpers/customer_helper.dart';
import 'package:davetcim/shared/sessions/application_cache.dart';
import 'package:davetcim/src/join/forgotPasswd/reset_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:davetcim/providers/app_provider.dart';
import 'package:davetcim/src/splash/splash_view.dart';
import 'package:davetcim/shared/environments/const.dart';
import '../../shared/enums/dialog_input_validator_type_enum.dart';
import '../../shared/utils/dialogs.dart';
import '../../shared/utils/form_control.dart';
import '../../shared/utils/utils.dart';
import '../home/home_view.dart';
import '../main/main_screen_view.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name;
  String surname;
  String gsmNo;
  String email;

  final forgotPasswordForm = GlobalKey <FormState> ();
  final TextEditingController oldPasswordControl = new TextEditingController();
  final TextEditingController passwordControl = new TextEditingController();
  final TextEditingController passwordAgainControl = new TextEditingController();

  @override
  void initState() {
    name = ApplicationCache.userCache.name;
    surname = ApplicationCache.userCache.surname;
    gsmNo = ApplicationCache.userCache.gsmNo;
    email = ApplicationCache.userCache.eMail;
    // TODO: implement initState
    super.initState();
  }

  void editCustomerName(String inputName) async {
    CustomerHelper customerHelper = CustomerHelper();
    await customerHelper.editCustomer(inputName, surname, email, gsmNo);
    setState(() {
      name = ApplicationCache.userCache.name;
    });
  }

  void editCustomerSurname(String inputSurname) async {
    CustomerHelper customerHelper = CustomerHelper();
    await customerHelper.editCustomer(name, inputSurname, email, gsmNo);
    setState(() {
      surname = ApplicationCache.userCache.surname;
    });
  }

  void editCustomerGSMNo(String inputGsm) async {
    CustomerHelper customerHelper = CustomerHelper();
    await customerHelper.editCustomer(name, surname, email, inputGsm);
    setState(() {
      gsmNo = ApplicationCache.userCache.gsmNo;
    });
  }

  void editCustomerEmail(String inputEmail) async {
    CustomerHelper customerHelper = CustomerHelper();
    await customerHelper.editCustomer(name, surname, inputEmail, gsmNo);
    setState(() {
      email = ApplicationCache.userCache.eMail;
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
                            ApplicationCache.userCache.username,
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
                            ApplicationCache.userCache.eMail,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          ApplicationCache.userCache = null;
                          Utils.navigateToPage(context, MainScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
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
                  Dialogs.showDialogMessageWithInputBox(context, "İsim Güncelle", "Vazgeç", "Onayla", name, 2,
                      editCustomerName, DailogInmputValidatorTypeEnum.name);
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
                  Dialogs.showDialogMessageWithInputBox(context, "Soyisim Güncelle", "Vazgeç", "Onayla", surname, 2,
                      editCustomerSurname, DailogInmputValidatorTypeEnum.surname);
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
                  Dialogs.showDialogMessageWithInputBox(context, "Email Güncelle", "Vazgeç", "Onayla", email, 2,
                      editCustomerEmail, DailogInmputValidatorTypeEnum.email);
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
                  Dialogs.showDialogMessageWithInputBox(context, "Telefon Güncelle", "Vazgeç", "Onayla", gsmNo, 2,
                      editCustomerGSMNo, DailogInmputValidatorTypeEnum.telephone);
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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text('Şifre Güncelle'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: forgotPasswordForm,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller:  oldPasswordControl,
                                    validator: (password) {
                                      return FormControlUtil.getErrorControl(FormControlUtil.getPasswordCompareControl(oldPasswordControl.text, ApplicationCache.userCache.password));
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Eski Şifre',
                                      icon: Icon(Icons.person_remove),
                                    ),
                                  ),
                                  TextFormField(
                                    controller:  passwordControl,
                                    decoration: InputDecoration(
                                      labelText: 'Yeni Şifre',
                                      icon: Icon(Icons.person),
                                    ),
                                  ),
                                  TextFormField(
                                    controller:  passwordAgainControl,
                                    validator: (email) {
                                      return FormControlUtil.getErrorControl(FormControlUtil.getPasswordCompareControl(passwordControl.text, passwordAgainControl.text));
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Yeni Şifre Tekrar',
                                      icon: Icon(Icons.person_add_alt_1 ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            MaterialButton(
                                child: Text("Reddet"),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true).pop(PageTransition(type: PageTransitionType.fade));
                                },
                            elevation: 10,
                              splashColor: Colors.blue,
                              color: Colors.redAccent,
                            ),
                            MaterialButton(
                              child: Text("Onayla"),
                              onPressed: () {
                                if (forgotPasswordForm.currentState.validate()) {
                                  ResetPasswdViewModel rpvm = ResetPasswdViewModel();
                                  rpvm.userResetPassword(context, ApplicationCache.userCache.id, passwordControl.text);
                                  Navigator.of(context, rootNavigator: true).pop(PageTransition(type: PageTransitionType.fade));
                                }
                              },
                              elevation: 10,
                              splashColor: Colors.green,
                              color: Colors.redAccent,
                            ),
                          ],
                        );
                      });
                },
                tooltip: "Şifre Değiştir",
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
