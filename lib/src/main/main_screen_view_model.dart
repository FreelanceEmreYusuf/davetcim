import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/utils/dialogs.dart';

class MainScreenViewModel extends ChangeNotifier {

  void navigateToLogin(BuildContext context) {
    Dialogs.showInfoModalContent(
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