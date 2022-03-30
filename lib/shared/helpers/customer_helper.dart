import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/environments/const.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/language.dart';

class CustomerHelper{

  static Future<String> getUserExistingControlWithUserName(String userName) async {

    String errorMessage = '';
    Database db = Database();
    CollectionReference docsRef = db.getCollectionRef(Constants.customerDB);
    var userResponseForUserName = await docsRef.where('username'.toString().toLowerCase(), isEqualTo: userName.toLowerCase()).get();

    if (userResponseForUserName.docs != null && userResponseForUserName.docs.length > 0) {
      errorMessage = LanguageConstants.dialogRegisterExistUserNameMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }

  static Future<String> getUserExistingControlWithEmail(String email) async {

    String errorMessage = '';
    Database db = Database();
    CollectionReference docsRef = db.getCollectionRef(Constants.customerDB);
    var userResponseForEmail = await docsRef.where('eMail', isEqualTo: email).get();

    if(userResponseForEmail.docs != null && userResponseForEmail.docs.length > 0){
      errorMessage = LanguageConstants.dialogRegisterExistEmailMessage[LanguageConstants.languageFlag];
    }

    return errorMessage;
  }
}