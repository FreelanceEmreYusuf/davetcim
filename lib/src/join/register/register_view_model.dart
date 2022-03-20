import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/environments/db_constants.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';

class RegisterViewModel extends ChangeNotifier {
  Database db = Database();

  Future<void> customerUserRegisterFlow(
      BuildContext context,
      Widget childPage,
      String _usernameControl,
      String _emailControl,
      String _passwordControl,
      String _phoneControl,
      String _nameControl,
      String _surnameControl) async {}

  Future<void> createCustomer(
      String _usernameControl,
      String _emailControl,
      String _passwordControl,
      String _phoneControl,
      String _nameControl,
      String _surnameControl) async {
    CustomerModel _customer = new CustomerModel(
      username: _usernameControl,
      id: new DateTime.now().millisecondsSinceEpoch,
      corporationId: 1,
      gsmNo: _phoneControl,
      isActive: true,
      name: _nameControl,
      password: _passwordControl,
      roleId: 2,
      surname: _surnameControl,
      eMail: _emailControl,
    );

    db.addCollectionRef("Customer", _customer.toMap());
  }

  /*static Future<bool> formControls(
      BuildContext context,
      String userName,
      String password,
      String fullName,
      String regionCode,
      String phoneNumber,
      String email,
      String address,
      String companyName,
      String questionAnswer,
      ComboItem selectedLanguage) async {
    CollectionReference docsRef = Utils.getCollectionRef(Constants.userDb);
    var response = await docsRef.where('userName', isEqualTo: userName).get();
    if (response.docs != null && response.docs.length > 0) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessUserNameMessage[
              LanguageConstants.languageFlag]);
      return false;
    }
    if (password.length < 8) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessPasswordMessage[
              LanguageConstants.languageFlag]);
      return false;
    }
    if (fullName.length < 1) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessFullNameMessage[
              LanguageConstants.languageFlag]);
      return false;
    }
    if (regionCode.length < 1) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessRegionCodeMessage[
              LanguageConstants.languageFlag]);
      return false;
    }
    if (phoneNumber.length < 1) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessPhoneNumberMessage[
              LanguageConstants.languageFlag]);
      return false;
    }
    if (!email.contains("@") || !email.contains(".") || email.length < 7) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessEmailMessage[
              LanguageConstants.languageFlag]);
      return false;
    }
    if (address.length < 1) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessAddressMessage[
              LanguageConstants.languageFlag]);
      return false;
    }
    if (companyName.length < 1) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessCompanyMessage[
              LanguageConstants.languageFlag]);
      return false;
    }
    if (questionAnswer.length < 1) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessQuestionAnswerMessage[
              LanguageConstants.languageFlag]);
      return false;
    }
    if (selectedLanguage == null) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.enterLanguageFlag[LanguageConstants.languageFlag]);
      return false;
    }

    return true;
  }*/

  Future<List<SecretQuestionsModel>> fillQuestionList() async {
    CollectionReference docsRef =
        db.getCollectionRef(DBConstants.secretQuestionsDb);
    var response = await docsRef.get();

    var list = response.docs;
    List<SecretQuestionsModel> secretQuestions = [];
    list.forEach((_secretQuestion) {
      Map item = _secretQuestion.data();
      secretQuestions.add(SecretQuestionsModel.fromMap(item));
    });

    return secretQuestions;
  }
}
