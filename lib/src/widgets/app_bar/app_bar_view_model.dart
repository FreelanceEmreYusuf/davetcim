import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/environments/db_constants.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:flutter/cupertino.dart';

class AppBarViewModel extends ChangeNotifier {

  Database db = Database();

  void showSucessMessage(BuildContext context) {
    Dialogs.showAlertMessageWithAction(
        context,
        "",
        //LanguageConstants.dialogSuccessHeader[LanguageConstants.languageFlag],
        LanguageConstants
            .dialogGoToLoginFromNotification[LanguageConstants.languageFlag],
        pushToJoinPage);
  }

  static void pushToJoinPage(BuildContext context) {
    Utils.navigateToPage(context, JoinView());
  }

  int getUserId() {
    int userId = 0;
    if (ApplicationSession.userSession != null) {
      userId = ApplicationSession.userSession.id;
    }
  }

  Stream<List<CustomerModel>> getUserInfo() {
    Stream<List<DocumentSnapshot>> userListInfo = db.getCollectionRef(DBConstants.customerDB)
        .where('id', isEqualTo: getUserId()).snapshots()
        .map((event) => event.docs);

    Stream<List<CustomerModel>> customerModellist =
        userListInfo.map((event) => event.map((e) => CustomerModel.fromMap(e.data())));

    return customerModellist;

  }

}