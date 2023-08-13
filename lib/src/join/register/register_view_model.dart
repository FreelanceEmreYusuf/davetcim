import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/helpers/customer_helper.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/enums/customer_role_enum.dart';
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
    String userExistControlWithUserName =
        await CustomerHelper.getUserExistingControlWithUserName(username);
    String userExistControlWithEmail =
        await CustomerHelper.getUserExistingControlWithEmail(email);
    String errorMessage = userExistControlWithUserName.isNotEmpty
        ? userExistControlWithUserName
        : userExistControlWithEmail;
    if (errorMessage.isEmpty) {
      await createCustomer(username, email, password, phoneNumber, name,
          surname, selectedQuestion, questionAnswer);
      showSucessMessage(context);
    } else {
      Dialogs.showAlertMessage(context, "Bilgilendirme!", errorMessage);
    }
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
        corporationId: 0,
        gsmNo: _phoneControl,
        isActive: true,
        name: _nameControl,
        password: _passwordControl,
        roleId: CustomerRoleEnum.user,
        recordDate: Timestamp.now(),
        surname: _surnameControl,
        eMail: _emailControl,
        secretQuestionId: selectedQuestion.id,
        secretQuestionAnswer: selectedQuestionAnswer,
        notificationCount: 0,
        basketCount: 0);

    db.editCollectionRef("Customer", _customer.toMap());
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
