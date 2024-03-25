import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_context.dart';
import 'package:davetcim/shared/sessions/user_state.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/enums/customer_role_enum.dart';
import '../../admin_corporate_panel/company/add_corporation/corporation_add_view.dart';
import '../../fav_products/fav_products_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  Database db = Database();

  Future<bool> userLoginFlow(BuildContext context, Widget childPage,
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

     if (customer.roleId == CustomerRoleEnum.organizationOwner && customer.corporationId == 0) {
        Utils.navigateToPage(context, CorporationAddView());
      } else {
        Utils.navigateToPage(context, childPage);
      }

      return true;
    } else {

      return false;
    }
  }

  Future<void> fillUserSession(CustomerModel customer) async{
    UserState.setFromCustomer(customer);
    FavProductsViewModel favMdl = FavProductsViewModel();
    UserState.favoriteCorporationList = await favMdl.getFavProductsList();
  }
}
