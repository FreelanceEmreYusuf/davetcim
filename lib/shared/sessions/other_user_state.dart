import '../enums/customer_role_enum.dart';
import '../models/customer_model.dart';

class OtherUserState {
  static int id;
  static String name;
  static String surname;
  static String gsmNo;
  static int corporationId;
  static CustomerRoleEnum roleId;
  static bool isActive;
  static String username;
  static String eMail;
  static String password;
  static int secretQuestionId;
  static String secretQuestionAnswer;
  static bool isNewUser;

  static bool isPresent() {
    return id != null && id > 0;
  }

  static void setFromCustomer(CustomerModel customer) {
    id = customer.id;
    name = customer.name;
    surname = customer.surname;
    gsmNo = customer.gsmNo;
    corporationId = customer.corporationId;
    roleId = customer.roleId;
    isActive = customer.isActive;
    username = customer.username;
    eMail = customer.eMail;
    password = customer.password;
    secretQuestionId = customer.secretQuestionId;
    secretQuestionAnswer = customer.secretQuestionAnswer;
    isNewUser = false;
    customer = null;
  }

  static void setAsNull() {
    id = null;
    name = null;
    surname = null;
    gsmNo = null;
    corporationId = null;
    roleId = null;
    isActive = null;
    username = null;
    eMail = null;
    password = null;
    secretQuestionId = null;
    secretQuestionAnswer = null;
    isNewUser = null;
  }
}
