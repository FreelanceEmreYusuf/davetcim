import '../enums/customer_role_enum.dart';

class UserSessionDto {
  final int id;
  final String name;
  final String surname;
  final String gsmNo;
  final int corporationId;
  final CustomerRoleEnum roleId;
  final bool isActive;
  final String username;
  final String eMail;

  const UserSessionDto(
      this.id,
      this.name,
      this.surname,
      this.gsmNo,
      this.corporationId,
      this.roleId,
      this.isActive,
      this.username,
      this.eMail);
}
