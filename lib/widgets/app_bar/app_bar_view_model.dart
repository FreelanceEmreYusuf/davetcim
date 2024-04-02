import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/sessions/user_state.dart';
import '../modal_content/info_modal_content.dart';

class AppBarViewModel extends ChangeNotifier {
  Database db = Database();

  void showSucessMessage(BuildContext context) {
    InfoModalContent.showInfoModalContent(
        context,
        "",
        LanguageConstants
            .dialogGoToLoginFromNotification[LanguageConstants.languageFlag],
        pushToJoinPage);
  }

  static void pushToJoinPage(BuildContext context) {
    Utils.navigateToPage(context, JoinView());
  }

  int getUserId() {
    if (UserState.isPresent()) {
      return UserState.id;
    }
    return 0;
  }

  Stream<List<CustomerModel>> getUserInfo() {
    Stream<List<DocumentSnapshot>> userListInfo = db
        .getCollectionRef(DBConstants.customerDB)
        .where('id', isEqualTo: getUserId())
        .snapshots()
        .map((event) => event.docs);

    Stream<List<CustomerModel>> customerModellist = userListInfo
        .map((event) => event.map((e) => CustomerModel.fromMap(e.data())).toList());

    return customerModellist;
  }
}
