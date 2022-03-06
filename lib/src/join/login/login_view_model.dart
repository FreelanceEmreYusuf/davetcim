import 'package:davetcim/environments/db_constants.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/shared/sessions/user_session.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {

  Database db = Database();

  Future<void> userLoginFlow(BuildContext context, Widget childPage,
      String userName, String password) async {
    var response = await db.getCollectionRef(DBConstants.customerDB)
        .where('username', isEqualTo: userName)
        .where('password', isEqualTo: password).get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      fillUserSession(list[0].data());
      Utils.navigateToPage(context, childPage);
    } else {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants.dialogUnSuccessHeader[
          LanguageConstants.languageFlag],
          LanguageConstants.kullaniciAdiYaDaParolaYanlis[
          LanguageConstants.languageFlag]);
    }
  }

  void fillUserSession(Map item) {
    ApplicationSession.userSession = UserSession(
        int.parse(item["id"].toString()),
        item["name"].toString(),
        item["surname"].toString(),
        item["gsmNo"].toString(),
        int.parse(item["corporationId"].toString()),
        int.parse(item["roleId"].toString()),
        item["isActive"],
        item["username"].toString()
    );
  }



}