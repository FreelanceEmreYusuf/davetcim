import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/environments/const.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:flutter/cupertino.dart';

class FormControlExtention{

  Future<bool> getRegisterFormElementsControl(
      BuildContext context,
      String userName,
      String password,
      String name,
      String surname,
      String phoneNumber,
      String email,
      String questionAnswer,
      SecretQuestionsModel selectedQuestion) async {
    Database db = Database();
    String errorMessage = '';
    String title = LanguageConstants.dialogUnSuccessHeader[LanguageConstants.languageFlag];
    CollectionReference docsRef = db.getCollectionRef(Constants.customerDB);
    var userResponseForUserName = await docsRef.where('username'.toString().toLowerCase(), isEqualTo: userName.toLowerCase()).get();
    var userResponseForEmail = await docsRef.where('eMail', isEqualTo: email).get();

    if (userResponseForUserName.docs != null && userResponseForUserName.docs.length > 0) {
      errorMessage = LanguageConstants.dialogRegisterExistUserNameMessage[LanguageConstants.languageFlag];
    }
    else if(userResponseForEmail.docs != null && userResponseForEmail.docs.length > 0){
      errorMessage = LanguageConstants.dialogRegisterExistEmailMessage[LanguageConstants.languageFlag];
    }
    else if (name.length < 1) {
      errorMessage = LanguageConstants.dialogRegisterUnSuccessFullNameMessage[LanguageConstants.languageFlag];
    }
    else if (surname.length < 1) {
      errorMessage = LanguageConstants.dialogRegisterUnSuccessFullNameMessage[LanguageConstants.languageFlag];
    }
    else if (userName.length < 8) {
      errorMessage = LanguageConstants.dialogRegisterUnSuccessFullUserNameMessage[LanguageConstants.languageFlag];
    }
    else if (password.length < 8) {
      errorMessage = LanguageConstants.dialogRegisterUnSuccessPasswordMessage[LanguageConstants.languageFlag];
    }
    else if (phoneNumber.length < 1) {
      errorMessage = LanguageConstants.dialogRegisterUnSuccessPhoneNumberMessage[LanguageConstants.languageFlag];
    }
    else if(RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(email))
    {}
    else if (!email.contains("@") || !email.contains(".") || email.length < 7) {
      errorMessage = LanguageConstants.dialogRegisterUnSuccessEmailMessage[LanguageConstants.languageFlag];
    }
    else if (questionAnswer.length < 1) {
      errorMessage = LanguageConstants.dialogRegisterUnSuccessQuestionAnswerMessage[LanguageConstants.languageFlag];
    }
    else if (selectedQuestion == null) {
      errorMessage = LanguageConstants.enterLanguageFlag[LanguageConstants.languageFlag];
    }

    if(errorMessage.isNotEmpty)
    {
      Dialogs.showAlertMessage(context, title, errorMessage);
      return false;
    }

    return true;
  }
}
