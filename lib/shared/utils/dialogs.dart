import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../src/join/join_view.dart';
import 'language.dart';

class Dialogs {
  static showAlertMessage(BuildContext context, String title, String message) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = TextButton(
      child: Text(LanguageConstants.tamam[LanguageConstants.languageFlag]),
      onPressed: () {
        Navigator.of(context).pop();
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
        Navigator.of(context).pop();
        method(context);
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
        Navigator.of(context).pop();
        method(context, childPage);
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
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(LanguageConstants.evet[LanguageConstants.languageFlag]),
      onPressed: () {
        if (functionInput == '') {
          method();
        } else {
          method(functionInput);
        }
        Navigator.of(context, rootNavigator: true).pop();
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
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(LanguageConstants.evet[LanguageConstants.languageFlag]),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        method(context, input1, input2, input3, input4, input5);
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
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(LanguageConstants.evet[LanguageConstants.languageFlag]),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) {
            return JoinView();
          },
        ));
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

  static showDialogMessageWithInputBox(BuildContext context, String title,
      Function method) {
    final TextEditingController inputMessageControl = new TextEditingController();
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("İptal"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Sepeti Onayla"),
      onPressed: () {
        method(inputMessageControl.text);
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: TextFormField(
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          labelText: "Mesajınızı Girin",
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
        maxLines: 10,
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
