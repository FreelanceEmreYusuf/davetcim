import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/enums/customer_role_enum.dart';
import '../../../shared/environments/db_constants.dart';
import '../../../shared/models/company_model.dart';
import '../../../shared/utils/dialogs.dart';
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

    await createCustomer(firmName, username, email, password, phoneNumber, name,
        surname);
    showSucessMessage(context);
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
        roleId: CustomerRoleEnum.user,
        recordDate: Timestamp.now(),
        surname: surnameControl,
        eMail: emailControl,
        secretQuestionId: 3,
        secretQuestionAnswer: "istanbul",
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
        recordDate: Timestamp.now(),
        isActive: true);

    db.editCollectionRef("Company", company.toMap());
  }

  Future<CompanyModel> getById(int companyId) async {
    var response = await db
        .getCollectionRef(DBConstants.companyDb)
        .where('id', isEqualTo:companyId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      CompanyModel companyModel = CompanyModel.fromMap(list[0].data());
      return companyModel;
    } else {
      return null;
    }
  }


  void showSucessMessage(BuildContext context) {
    Dialogs.showInfoModalContent(
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
