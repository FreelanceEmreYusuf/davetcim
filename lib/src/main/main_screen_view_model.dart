import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:flutter/cupertino.dart';

class MainScreenViewModel extends ChangeNotifier {

  void navigateToLogin(BuildContext context) {
    Dialogs.showAlertMessageWithAction(
        context,
        LanguageConstants.dialogSuccessHeader[LanguageConstants.languageFlag],
        LanguageConstants
            .dialogGoToLogin[LanguageConstants.languageFlag],
        pushToJoinPage);
  }

  static void pushToJoinPage(BuildContext context) {
    Utils.navigateToPage(context, JoinView());
  }
}