import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/environments/const.dart';
import 'package:davetcim/environments/db_constants.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/cupertino.dart';

import '../join_view.dart';

class RegisterViewModel extends ChangeNotifier {
  Database db = Database();

  Future<void> customerUserRegisterFlow(
      BuildContext context,
      String username,
      String password,
      String name,
      String surname,
      String phoneNumber,
      String email,
      String questionAnswer,
      SecretQuestionsModel selectedQuestion) async {

    if (await formControls(context,username, password,name,surname,
      phoneNumber,email,questionAnswer,selectedQuestion)) {
      await createCustomer(username, email, password, phoneNumber,
          name, surname,selectedQuestion,questionAnswer);
      showSucessMessage(context);
    }
  }

  Future<bool> formControls(
      BuildContext context,
      String userName,
      String password,
      String name,
      String surname,
      String phoneNumber,
      String email,
      String questionAnswer,
      SecretQuestionsModel selectedQuestion) async {
    CollectionReference docsRef = db.getCollectionRef(Constants.customerDB);
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
    if (name.length < 1) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessFullNameMessage[
          LanguageConstants.languageFlag]);
      return false;
    }
    if (surname.length < 1) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessFullNameMessage[
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
    if (questionAnswer.length < 1) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.dialogRegisterUnSuccessQuestionAnswerMessage[
          LanguageConstants.languageFlag]);
      return false;
    }
    if (selectedQuestion == null) {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants.enterLanguageFlag[LanguageConstants.languageFlag]);
      return false;
    }

    return true;
  }

  Future<void> createCustomer(
      String _usernameControl,
      String _emailControl,
      String _passwordControl,
      String _phoneControl,
      String _nameControl,
      String _surnameControl,
      SecretQuestionsModel selectedQuestion,
      String selectedQuestionAnswer) async {
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
      secretQuestionId: selectedQuestion.id,
      secretQuestionAnswer: selectedQuestionAnswer
    );

    db.addCollectionRef("Customer", _customer.toMap());

  }

  void showSucessMessage(BuildContext context) {
    Dialogs.showAlertMessageWithAction(
        context,
        LanguageConstants.dialogSuccessHeader[LanguageConstants.languageFlag],
        LanguageConstants
            .dialogSuccessUserMessage[LanguageConstants.languageFlag],
        pushToJoinPage);
  }

  static void pushToJoinPage(BuildContext context) {
    Utils.navigateToPage(context, JoinView());
  }

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
