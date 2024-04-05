import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/utils/form_control.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../src/join/join_view.dart';
import '../enums/dialog_input_validator_type_enum.dart';
import 'language.dart';

class Dialogs {

  static void showInfoModalContent(
      BuildContext context,
      String header,
      String text,
      Function method,
      ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
        Color backgroundColor = isDarkMode ? Colors.grey[900] : Colors.white;
        Color textColor = isDarkMode ? Colors.white : Colors.black;
        Color buttonColor = isDarkMode ? Colors.blue : Colors.blue;

        return Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                header,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: textColor,
                ),
              ),
              SizedBox(height: 20),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (method != null) {
                    method(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  "Tamam",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showDialogModalContentWithInputBox(BuildContext context, String title, String cancelButtonText,
      String okButtonText, String labelText, int maxLines, Function method, DailogInmputValidatorTypeEnum validationType, {int lineCount = 1}) {
    final TextEditingController inputMessageControl = new TextEditingController();
    final registerFormKey = GlobalKey<FormState>();
    final FocusNode _focusNode = FocusNode();

    FormFieldValidator<String> validator;
    TextInputType inputType = TextInputType.text;
    if (validationType == DailogInmputValidatorTypeEnum.name) {
      validator = (name) {
        return FormControlUtil.getErrorControl(
            FormControlUtil.getStringLenghtBetweenMinandMaxControl(name, 3, 15));
      };
    } else if (validationType == DailogInmputValidatorTypeEnum.surname) {
      validator = (surname) {
        return FormControlUtil.getErrorControl(
            FormControlUtil.getStringLenghtBetweenMinandMaxControl(surname, 2, 15));
      };
    } else if (validationType == DailogInmputValidatorTypeEnum.telephone) {
      inputType = TextInputType.number;
      validator = (phoneNumber) {
        return FormControlUtil.getErrorControl(FormControlUtil.getPhoneNumberControl(phoneNumber));
      };
    } else if (validationType == DailogInmputValidatorTypeEnum.email) {
      validator = (email) {
        return FormControlUtil.getErrorControl(FormControlUtil.getEmailAdressControl(email));
      };
    } else {
      validator = (anything) {
        return FormControlUtil.getErrorControl(
            FormControlUtil.getStringLenghtBetweenMinandMaxControl(anything, 0, 1500));
      };
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Klavye açıldığında alt sayfanın boyutunu otomatik ayarlar
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: registerFormKey,
            child: Container(
              padding: EdgeInsets.all(20.0),
              height: MediaQuery.of(context).size.height * 0.4, // Ekranın 2/3'ü kadar
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    focusNode: _focusNode,
                    validator: validator,
                    keyboardType: inputType,
                    decoration: InputDecoration(
                      labelText: labelText,
                      icon: Icon(Icons.update),
                    ),
                    controller: inputMessageControl,
                    maxLines: lineCount, // Çok satırlı girişi etkinleştirir, istediğiniz satır sayısını belirtebilirsiniz
                    onTap: () {}, // Klavyenin açılmasını engeller
                  ),

                  SizedBox(height: 10), // Boşluk ekleyin
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () {
                          if (registerFormKey.currentState.validate()) {
                            method(inputMessageControl.text);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(okButtonText),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(cancelButtonText),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }



  static showAlertMessage(BuildContext context, String title, String message) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = TextButton(
      child: Text(LanguageConstants.tamam[LanguageConstants.languageFlag]),
      onPressed: () {
        try{
          Navigator.of(context).pop(PageTransition());
        }
        catch(e) {

        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertMessageWithAction(
      BuildContext context, String title, String message, Function method) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = TextButton(
      child: Text(LanguageConstants.tamam[LanguageConstants.languageFlag]),
      onPressed: () {
        try{
        Navigator.of(context).pop(PageTransition());
        method(context);
        }
        catch(e) {

        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertMessageWithActionWithChildPage(BuildContext context,
      String title, String message, Function method, Widget childPage) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = TextButton(
      child: Text(LanguageConstants.tamam[LanguageConstants.languageFlag]),
      onPressed: () {
        try{
          Navigator.of(context).pop(PageTransition());
          method(context, childPage);
        }
        catch(e) {

        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showDialogMessage(BuildContext context, String title, String message,
      Function method, String functionInput) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(LanguageConstants.hayir[LanguageConstants.languageFlag]),
      onPressed: () {
        try{
          Navigator.of(context, rootNavigator: true).pop(PageTransition());
        }
        catch(e) {

        }
      },
    );
    Widget continueButton = TextButton(
      child: Text(LanguageConstants.evet[LanguageConstants.languageFlag]),
      onPressed: () {
        try{
          if (functionInput == '') {
            method();
          } else {
            method(functionInput);
          }
          Navigator.of(context, rootNavigator: true).pop(PageTransition());
        }
        catch(e) {

        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




  static showDialogForAddingComment(
      BuildContext context,
      String title,
      String message,
      Function method,
      DocumentReference<Object> input1,
      int input2,
      int input3,
      double input4,
      String input5) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(LanguageConstants.hayir[LanguageConstants.languageFlag]),
      onPressed: () {
        try{
          Navigator.of(context, rootNavigator: true).pop(PageTransition());
        }
        catch(e) {

        }
      },
    );
    Widget continueButton = TextButton(
      child: Text(LanguageConstants.evet[LanguageConstants.languageFlag]),
      onPressed: () {
        try{
          Navigator.of(context, rootNavigator: true).pop(PageTransition());
          method(context, input1, input2, input3, input4, input5);
        }
        catch(e) {

        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showLoginDialogMessage(BuildContext context, Widget callerPage) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(LanguageConstants.hayir[LanguageConstants.languageFlag]),
      onPressed: () {
        try{
          Navigator.of(context, rootNavigator: true).pop(PageTransition(type: PageTransitionType.fade));
        }
        catch(e) {

        }
      },
    );
    Widget continueButton = TextButton(
      child: Text(LanguageConstants.evet[LanguageConstants.languageFlag]),
      onPressed: () {
        try{
          Navigator.of(context, rootNavigator: true).pop(PageTransition());
          Utils.navigateToPage(context, JoinView());
        }
        catch(e) {

        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(LanguageConstants
          .processApproveHeader[LanguageConstants.languageFlag]),
      content: Text(LanguageConstants
          .userMustBeLoginToContinueMessage[LanguageConstants.languageFlag]),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showDialogMessageWithInputBox(BuildContext context, String title, String cancelButtonText,
      String okButtonText, String labelText, int maxLines, Function method, DailogInmputValidatorTypeEnum validationType) {
    final TextEditingController inputMessageControl = new TextEditingController();
    final registerFormKey = GlobalKey <FormState> ();
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(cancelButtonText),
      onPressed: () {
        try{
          Navigator.of(context, rootNavigator: true).pop(PageTransition());
        }
        catch(e) {

        }
      },
    );
    Widget continueButton = TextButton(
      child: Text(okButtonText),
      onPressed: () {
        try{
          if (registerFormKey.currentState.validate()) {
            method(inputMessageControl.text);
            Navigator.of(context, rootNavigator: true).pop(PageTransition());
          }
        }
        catch(e) {

        }
      },
    );

    FormFieldValidator<String> validator;
    TextInputType inputType = TextInputType.text;
    if (validationType == DailogInmputValidatorTypeEnum.name) {
      validator = (name) {
        return FormControlUtil.getErrorControl(
            FormControlUtil.getStringLenghtBetweenMinandMaxControl(name, 3, 15));
      };
    } else if (validationType == DailogInmputValidatorTypeEnum.surname) {
      validator = (surname) {
        return FormControlUtil.getErrorControl(
            FormControlUtil.getStringLenghtBetweenMinandMaxControl(surname, 2, 15));
      };
    } else if (validationType == DailogInmputValidatorTypeEnum.telephone) {
      inputType = TextInputType.number;
      validator = (phoneNumber) {
        return FormControlUtil.getErrorControl(FormControlUtil.getPhoneNumberControl(phoneNumber));
      };
    } else if (validationType == DailogInmputValidatorTypeEnum.email) {
      validator = (email) {
        return FormControlUtil.getErrorControl(FormControlUtil.getEmailAdressControl(email));
      };
    } else {
      validator = (anything) {
        return FormControlUtil.getErrorControl(
            FormControlUtil.getStringLenghtBetweenMinandMaxControl(anything, 0, 1500));
      };
    }

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: registerFormKey,
          child: TextFormField(
            validator: validator,
            keyboardType: inputType,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              labelText: labelText,
              filled: true,
              fillColor: Colors.white,
              focusColor: Colors.blue,
              prefixIcon: Icon(
                Icons.message,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            controller: inputMessageControl,
            maxLines: maxLines,
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
