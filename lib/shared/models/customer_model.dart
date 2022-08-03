import 'dart:math';

class CustomerModel {
  final int id;
  final String name;
  final String surname;
  final String gsmNo;
  final int corporationId;
  final int roleId;
  final bool isActive;
  final String username;
  final String password;
  final String eMail;
  final int secretQuestionId;
  final String secretQuestionAnswer;
  final int notificationCount;
  final int basketCount;

  CustomerModel(
      {this.id,
      this.name,
      this.surname,
      this.gsmNo,
      this.corporationId,
      this.roleId,
      this.isActive,
      this.username,
      this.password,
      this.eMail,
      this.secretQuestionId,
      this.secretQuestionAnswer,
      this.notificationCount,
      this.basketCount});

  ///Object to map
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'surname': surname,
        'gsmNo': gsmNo,
        'corporationId': corporationId,
        'roleId': roleId,
        'isActive': isActive,
        'username': username,
        'password': password,
        'eMail': eMail,
        'secretQuestionId': secretQuestionId,
        'secretQuestionAnswer': secretQuestionAnswer,
        'notificationCount': notificationCount,
        'basketCount': basketCount,
      };

  ///Map to object
  factory CustomerModel.fromMap(Map map) => CustomerModel(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      gsmNo: map['gsmNo'],
      corporationId: map['corporationId'],
      roleId: map['roleId'],
      isActive: map['isActive'],
      username: map['username'],
      password: map['password'],
      eMail: map['eMail'],
      secretQuestionId: map['secretQuestionId'],
      secretQuestionAnswer: map['secretQuestionAnswer'],
      notificationCount: map['notificationCount'],
      basketCount: map['basketCount']);
}
