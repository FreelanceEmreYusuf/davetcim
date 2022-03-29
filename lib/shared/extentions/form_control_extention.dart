import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/environments/const.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormControlExtention{

  Future<bool> getFormElementsControl(
      BuildContext context,
      String userName,
      String password,
      String name,
      String surname,
      String phoneNumber,
      String email,
      String questionAnswer,
      SecretQuestionsModel selectedQuestion) async {
    String errorMessage = '';
    String title = LanguageConstants.dialogUnSuccessHeader[LanguageConstants.languageFlag];

    errorMessage = await getNameControl(name);

    if (errorMessage.isEmpty) {
      errorMessage = getNameControl(name);
    }
    if (errorMessage.isEmpty) {
      errorMessage = getSurNameControl(surname);
    }
    if (errorMessage.isEmpty) {
      errorMessage = await getUserNameControl(surname);
    }
    if(errorMessage.isEmpty){
      errorMessage = await getUserNameControl(userName);
    }
    if(errorMessage.isEmpty){
      errorMessage = await getEmailControl(email);
    }
    if (errorMessage.isEmpty) {
      errorMessage = getPasswordControl(password);
    }
    if (errorMessage.isEmpty) {
      errorMessage = getPhoneNumberControl(phoneNumber);
    }
    if (errorMessage.isEmpty) {
      errorMessage = await getEmailControl(email);
    }
    if (errorMessage.isEmpty) {
      errorMessage = getSecretQuestionAnswerControl(questionAnswer);
    }
    if (selectedQuestion == null) {
      errorMessage = getSecretQuestionControl(selectedQuestion);
    }

    if(errorMessage.isNotEmpty)
    {
      Dialogs.showAlertMessage(context, title, errorMessage);
      return false;
    }

    return true;
  }

  Future<String> getUserExistingControl(String userNameOrEmail) async {

    String errorMessage = '';
    Database db = Database();
    CollectionReference docsRef = db.getCollectionRef(Constants.customerDB);
    var userResponseForUserName = await docsRef.where('username'.toString().toLowerCase(), isEqualTo: userNameOrEmail.toLowerCase()).get();
    var userResponseForEmail = await docsRef.where('eMail', isEqualTo: userNameOrEmail).get();

    if (userResponseForUserName.docs != null && userResponseForUserName.docs.length > 0) {
      errorMessage = LanguageConstants.dialogRegisterExistUserNameMessage[LanguageConstants.languageFlag];
    }
    else if(userResponseForEmail.docs != null && userResponseForEmail.docs.length > 0){
      errorMessage = LanguageConstants.dialogRegisterExistEmailMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }

  Future<String> getUserNameControl(String username) async {
    String errorMessage = '';

    if(username.isEmpty){
      errorMessage = LanguageConstants.dialogRegisterUnSuccessFullUserNameMessage[LanguageConstants.languageFlag].toString();
    }

    if(!(username.length > 2 && username.length < 71)){
      errorMessage = LanguageConstants.dialogRegisterUnSuccessFullUserNameMessage[LanguageConstants.languageFlag].toString();
    }

    if(errorMessage.isEmpty){
      errorMessage = await getUserExistingControl(username);
    }

    return errorMessage;
  }

  Future<String> getEmailControl(String email) async {
    String errorMessage = '';
    if(!email.contains("@") || !email.contains(".") || email.length < 7){
      errorMessage = LanguageConstants.dialogRegisterUnSuccessEmailMessage[LanguageConstants.languageFlag];
    }
    if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(email))
    {
      errorMessage = errorMessage = LanguageConstants.dialogRegisterUnSuccessEmailMessage[LanguageConstants.languageFlag];
    }

    if(errorMessage.isEmpty){
      errorMessage = await getUserExistingControl(email);
    }

    return errorMessage;
  }

  String getNameControl(String name){
    String errorMessage = '';

    if(name.isEmpty){
      errorMessage = LanguageConstants.cannotNullNameMessage[LanguageConstants.languageFlag].toString();
    }

    if(errorMessage.isEmpty && !(name.length > 2 && name.length < 71)){
      errorMessage = LanguageConstants.nameLengthMustBe3And70Message[LanguageConstants.languageFlag].toString();
    }

    return errorMessage;
  }

  String getSurNameControl(String surname){
    String errorMessage = '';

    if(surname.isEmpty){
      errorMessage = LanguageConstants.cannotNullSurnameMessage[LanguageConstants.languageFlag].toString();
    }

    if(!(surname.length > 2 && surname.length < 71)){
      errorMessage = LanguageConstants.surnameLengthMustBe3And70Message[LanguageConstants.languageFlag].toString();
    }

    return errorMessage;
  }

  String getPasswordControl(String password){
    String errorMessage = '';

    if(password.length < 8){
      errorMessage = LanguageConstants.passwordLengthMustBe8Message[LanguageConstants.languageFlag];
    }
    if(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password))    {
      errorMessage = LanguageConstants.passwordIncorrectMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }

  String getPhoneNumberControl(String phoneNumber){
    String errorMessage = '';

    if(phoneNumber.length != 10){
      errorMessage = LanguageConstants.dialogRegisterUnSuccessPhoneNumberMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }

  String getSecretQuestionAnswerControl(String questionAnswer){
    String errorMessage = '';

    if(questionAnswer.length < 1){
      errorMessage = LanguageConstants.dialogRegisterUnSuccessQuestionAnswerMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }

  String getSecretQuestionControl(SecretQuestionsModel selectedQuestion){
    String errorMessage = '';

    if(selectedQuestion == null){
      errorMessage = LanguageConstants.dialogRegisterUnSuccessQuestionAnswerMessage[LanguageConstants.languageFlag];
    }
    return errorMessage;
  }
  
  String getNullControl(String value){
    String errorMessage = '';

    if(value.isEmpty){
      errorMessage = LanguageConstants.formElementNullValueMessage[LanguageConstants.languageFlag];
    }
    return errorMessage;
  }

  String getValueBetween3and70Control(String value){
    String errorMessage = '';

    if(!(value.length > 2 && value.length < 71)){
      errorMessage = LanguageConstants.formElementValueBetween3and70Message[LanguageConstants.languageFlag].toString();
    }

    return errorMessage;
  }
}
