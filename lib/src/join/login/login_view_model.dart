import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/shared/dto/user_session_dto.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/enums/customer_role_enum.dart';
import '../../admin_corporate_panel/company/add_corporation/corporation_add_view.dart';
import '../../admin_corporate_panel/company/user_register/company_user_register_view.dart';
import '../../fav_products/fav_products_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  Database db = Database();

  Future<void> userLoginFlow(BuildContext context, Widget childPage,
      String userName, String password) async {
    var response = await db
        .getCollectionRef(DBConstants.customerDB)
        .where('username', isEqualTo: userName)
        .where('password', isEqualTo: password)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      CustomerModel customer = CustomerModel.fromMap(list[0].data());
      await fillUserSession(customer);

    /*  if (customer.roleId == CustomerRoleEnum.companyAdminNotRegistered) {
        Utils.navigateToPage(context, CompanyUserRegisterView());
      } else */if (customer.roleId == CustomerRoleEnum.companyAdmin && customer.corporationId == 0) {
        Utils.navigateToPage(context, CorporationAddView());
      } else {
        Utils.navigateToPage(context, childPage);
      }
    } else {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants
              .kullaniciAdiYaDaParolaYanlis[LanguageConstants.languageFlag]);
    }
  }

  Future<void> fillUserSession(CustomerModel customer) async{
    ApplicationSession.userSession = UserSessionDto(
        customer.id,
        customer.name,
        customer.surname,
        customer.gsmNo,
        customer.corporationId,
        customer.roleId,
        customer.isActive,
        customer.username,
        customer.eMail);
    ApplicationSession.notificationCount = customer.notificationCount;
    ApplicationSession.basketCount = customer.basketCount;

    FavProductsViewModel favMdl = FavProductsViewModel();
    ApplicationSession.favoriteCorporationList = await favMdl.getFavProductsList();
  }
}
