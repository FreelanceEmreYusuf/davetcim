import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/models/secret_questions_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../join_view.dart';

class ResetPasswdViewModel extends ChangeNotifier {
  Database db = Database();

  Future<bool> userResetPasswordFlow(
      BuildContext context,
      String userName,
      String email,
      String password,
      int secretQuestionId,
      String secretQuestionAnswer) async {
    var response = await db
        .getCollectionRef(DBConstants.customerDB)
        .where('username', isEqualTo: userName)
        .where('eMail', isEqualTo: email)
        .where('secretQuestionId', isEqualTo: secretQuestionId)
        .where('secretQuestionAnswer', isEqualTo: secretQuestionAnswer)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      CustomerModel customer = CustomerModel.fromMap(list[0].data());
      Map<String, dynamic> customerMap = customer.toMap();
      customerMap['password'] = password;
      db.editCollectionRef("Customer", customerMap);
      showSucessMessage(context);

      return true;
    } else {
      return false;
    }
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
