import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/language.dart';

import '../../src/fav_products/fav_products_view_model.dart';
import '../environments/db_constants.dart';
import '../models/customer_model.dart';
import '../sessions/user_state.dart';

class CustomerHelper {

  Future<CustomerModel> getCustomer(int customerId) async {
    Database db = Database();
    var response = await db
        .getCollectionRef(DBConstants.customerDB)
        .where('id', isEqualTo: customerId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      CustomerModel customer = CustomerModel.fromMap(list[0].data());
      return customer;
    }

    return null;
  }

  Future<CustomerModel> getCustomerByUserName(String userName) async {
    Database db = Database();
    var response = await db
        .getCollectionRef(DBConstants.customerDB)
        .where('username', isEqualTo: userName)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      CustomerModel customer = CustomerModel.fromMap(list[0].data());
      return customer;
    }

    return null;
  }

  Future<void> fillUserSession(CustomerModel customer) async {
    UserState.setFromCustomer(customer);
    FavProductsViewModel favMdl = FavProductsViewModel();
    UserState.favoriteCorporationList = await favMdl.getFavProductsList();
  }

  Future<void> editCustomer(String name, String surname, String email, String gsmNo) async {
    Database db = Database();
    CustomerModel customerModel = await getCustomer(UserState.id);
    customerModel.name = name;
    customerModel.surname = surname;
    customerModel.eMail = email;
    customerModel.gsmNo = gsmNo;
    UserState.setFromCustomer(customerModel);
    await db.editCollectionRef(DBConstants.customerDB, customerModel.toMap());
  }

  static Future<String> getUserExistingControlWithUserName(
      String userName) async {
    String errorMessage = '';
    Database db = Database();
    CollectionReference docsRef = db.getCollectionRef(Constants.customerDB);
    var userResponseForUserName = await docsRef
        .where('username'.toString().toLowerCase(),
            isEqualTo: userName.toLowerCase())
        .get();

    if (userResponseForUserName.docs != null &&
        userResponseForUserName.docs.length > 0) {
      errorMessage = LanguageConstants
          .dialogRegisterExistUserNameMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }

  static Future<String> getUserExistingControlWithEmail(String email) async {
    String errorMessage = '';
    Database db = Database();
    CollectionReference docsRef = db.getCollectionRef(Constants.customerDB);
    var userResponseForEmail =
        await docsRef.where('eMail', isEqualTo: email).get();

    if (userResponseForEmail.docs != null &&
        userResponseForEmail.docs.length > 0) {
      errorMessage = LanguageConstants
          .dialogRegisterExistEmailMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }

  Future<List<CustomerModel>> getActiveCustomers() async {
    Database db = Database();
    List<CustomerModel> customerList =[];
    var response = await db
        .getCollectionRef(DBConstants.customerDB)
        .where('isActive', isEqualTo: true)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        customerList.add(CustomerModel.fromMap(list[i].data()));
      }
      return customerList;
    }

    return null;
  }

}
