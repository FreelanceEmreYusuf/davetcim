import 'package:davetcim/shared/helpers/customer_helper.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/enums/customer_role_enum.dart';

class CommonInformationsP2ViewModel extends ChangeNotifier {
  Database db = Database();
  Future<void> customerUserRegisterFlow(
      BuildContext context,
      String addres,
      String name,
      String description,
      String phoneNumber,
      String email) async {
    /*String userExistControlWithUserName =
        await CustomerHelper.getUserExistingControlWithUserName(addres);
    String userExistControlWithEmail =
        await CustomerHelper.getUserExistingControlWithEmail(email);
    String errorMessage = userExistControlWithUserName.isNotEmpty
        ? userExistControlWithUserName
        : userExistControlWithEmail;*/
  }

}
