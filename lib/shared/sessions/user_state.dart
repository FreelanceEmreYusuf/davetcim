import '../enums/customer_role_enum.dart';
import '../models/customer_model.dart';

class UserState {
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
  static int notificationCount;
  static int basketCount;
  static List<int> favoriteCorporationList;

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
    notificationCount = customer.notificationCount;
    basketCount = customer.basketCount;
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
    notificationCount = null;
    basketCount = null;
    favoriteCorporationList = null;
  }

  static bool isCorporationFavorite(int corporationId) {
    if (favoriteCorporationList == null) {
      return false;
    }
    for (int i = 0; i < favoriteCorporationList.length; i++) {
      if (corporationId == favoriteCorporationList[i]) {
        return true;
      }
    }
    return false;
  }
}
