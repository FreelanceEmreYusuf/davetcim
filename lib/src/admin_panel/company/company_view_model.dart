import 'package:davetcim/shared/helpers/customer_helper.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/enums/customer_role_enum.dart';
import '../../../shared/models/company_model.dart';
import '../AdminPanel.dart';

class CompanyViewModel extends ChangeNotifier {
  Database db = Database();
  Future<void> companyAddRegisterFlow(
      BuildContext context,
      String firmName,
      String username,
      String password,
      String name,
      String surname,
      String phoneNumber,
      String email) async {
    String userExistControlWithUserName =
    await CustomerHelper.getUserExistingControlWithUserName(username);
    String userExistControlWithEmail =
    await CustomerHelper.getUserExistingControlWithEmail(email);
    String errorMessage = userExistControlWithUserName.isNotEmpty
        ? userExistControlWithUserName
        : userExistControlWithEmail;
    if (errorMessage.isEmpty) {
      await createCustomer(firmName, username, email, password, phoneNumber, name,
          surname);
      showSucessMessage(context);
    } else {
      Dialogs.showAlertMessage(context, "Bilgilendirme!", errorMessage);
    }
  }

  Future<void> createCustomer(
      String firmNameControl,
      String usernameControl,
      String emailControl,
      String passwordControl,
      String phoneControl,
      String nameControl,
      String surnameControl) async {
    int customerId = new DateTime.now().millisecondsSinceEpoch;
    CustomerModel _customer = new CustomerModel(
        username: usernameControl,
        id: customerId,
        corporationId: 0,
        gsmNo: phoneControl,
        isActive: true,
        name: nameControl,
        password: passwordControl,
        roleId: CustomerRoleEnum.companyAdminNotRegistered,
        surname: surnameControl,
        eMail: emailControl,
        secretQuestionId: 0,
        secretQuestionAnswer: "",
        notificationCount: 0,
        basketCount: 0);

    db.editCollectionRef("Customer", _customer.toMap());
    createCompany(customerId, firmNameControl);
  }

  Future<void> createCompany(int customerId, String firmName) {
    CompanyModel company = new CompanyModel(
        id: new DateTime.now().millisecondsSinceEpoch,
        name: firmName,
        customerId: customerId,
        isActive: true);

    db.editCollectionRef("Company", company.toMap());
  }


  void showSucessMessage(BuildContext context) {
    Dialogs.showAlertMessageWithAction(
        context,
        LanguageConstants.dialogSuccessHeader[LanguageConstants.languageFlag],
        LanguageConstants
            .dialogSuccessUserMessage[LanguageConstants.languageFlag],
        pushToAdminLandingPage);
  }

  static void pushToAdminLandingPage(BuildContext context) {
    Utils.navigateToPage(context, AdminPanelPage());
  }
}
