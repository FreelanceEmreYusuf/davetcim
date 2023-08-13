enum CustomerRoleEnum {
  empty,
  companyAdmin,
  user,
  admin,
}

class CustomerRoleEnumConverter {
  static CustomerRoleEnum getEnumValue(int value) {
    return CustomerRoleEnum.values[value];
  }

  static int getEnumIndexValue(CustomerRoleEnum value) {
    return value.index;
  }

  static bool isAdmin(CustomerRoleEnum value) {
    return CustomerRoleEnum.user != value;
  }
}