import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/shared/utils/language.dart';

import '../environments/db_constants.dart';
import '../models/customer_model.dart';

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

  Future<void> editCustomer(String name, String surname, String email, String gsmNo) async {
    Database db = Database();
    CustomerModel customerModel = await getCustomer(ApplicationSession.userSession.id);
    customerModel.name = name;
    customerModel.surname = surname;
    customerModel.eMail = email;
    customerModel.gsmNo = gsmNo;
    ApplicationSession.userSession.gsmNo = gsmNo;
    ApplicationSession.userSession.name = name;
    ApplicationSession.userSession.surname = surname;
    ApplicationSession.userSession.eMail = email;
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



}
