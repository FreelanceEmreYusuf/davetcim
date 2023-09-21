import '../enums/customer_role_enum.dart';

class UserSessionDto {
  int id;
  String name;
  String surname;
  String gsmNo;
  int corporationId;
  CustomerRoleEnum roleId;
  bool isActive;
  String username;
  String eMail;
  String password;

  UserSessionDto(
      this.id,
      this.name,
      this.surname,
      this.gsmNo,
      this.corporationId,
      this.roleId,
      this.isActive,
      this.username,
      this.eMail,
      this.password);
}
