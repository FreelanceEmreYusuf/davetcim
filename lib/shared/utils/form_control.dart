import 'dart:developer';

import 'language.dart';

class FormControlUtil{
  static String getErrorControl(String errorMessage){
    if(errorMessage.isEmpty || errorMessage == null)
      return null;

    return errorMessage;
  }

  static String getDefaultFormValueControl(String value){
    String errorMessage = getStringEmptyValueControl(value);

    if(errorMessage.isEmpty)
    {
      errorMessage = getStringLenghtBetween3and70Control(value);
    }

    return errorMessage;
  }

  static String getEmailAdressControl(String value)
  {
    String errorMessage = getDefaultFormValueControl(value);

    if(errorMessage.isEmpty)
    {
      errorMessage = FormControlUtil.getSuccessEmailAdressControl(value);
    }

    return errorMessage;
  }

  static String getPhoneNumberControl(String value){
    String errorMessage = getDefaultFormValueControl(value);

    if(errorMessage.isEmpty){
      errorMessage = getValueLength10Control(value);
    }

    if(errorMessage.isEmpty)
    {
      errorMessage = getValueStartNumber5Control(value);
    }

    return errorMessage;
  }

  static String getPasswordControl(String password){
    String errorMessage = "";

    if(password.length < 8){
      errorMessage = LanguageConstants.passwordLengthMustBe8Message[LanguageConstants.languageFlag];
    }
    if(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password))    {
      errorMessage = LanguageConstants.passwordIncorrectMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }

  static getStringEmptyValueControl(String value){
    String errorMessage = '';
    if(value.isEmpty || value == null){
      errorMessage = LanguageConstants.formElementNullValueMessage[LanguageConstants.languageFlag];
    }
    return errorMessage;
  }

  static String getStringLenghtBetween3and70Control(String value){
    String errorMessage = '';

    if(!(value.length >= 3 && value.length <= 70)){
      errorMessage = LanguageConstants.formElementValueBetween3and70Message[LanguageConstants.languageFlag].toString();
    }

    return errorMessage;
  }

  static String getSuccessEmailAdressControl(String email) {
    String errorMessage = '';

    if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(email))
    {
      errorMessage = errorMessage = LanguageConstants.dialogRegisterUnSuccessEmailMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }

  static String getValueLength10Control(String value) {
    String errorMessage = '';

    if(value.length != 10){
      errorMessage = LanguageConstants.dialogRegisterUnSuccessPhoneNumberMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }

  static String getValueStartNumber5Control(String value) {
    String errorMessage = '';

    if(value[0] != "5"){
      errorMessage = LanguageConstants.dialogRegisterUnSuccessPhoneNumberMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }
}