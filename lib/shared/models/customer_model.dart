import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/customer_role_enum.dart';

class CustomerModel {
  final int id;
  String name;
  String surname;
  String gsmNo;
  int corporationId;
  CustomerRoleEnum roleId;
  bool isActive;
  String username;
  String password;
  String eMail;
  int secretQuestionId;
  String secretQuestionAnswer;
  int notificationCount;
  int basketCount;
  Timestamp recordDate;

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
      this.basketCount,
      this.recordDate});

  ///Object to map
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'surname': surname,
        'gsmNo': gsmNo,
        'corporationId': corporationId,
        'roleId': roleId.index,
        'isActive': isActive,
        'username': username,
        'password': password,
        'eMail': eMail,
        'secretQuestionId': secretQuestionId,
        'secretQuestionAnswer': secretQuestionAnswer,
        'notificationCount': notificationCount,
        'basketCount': basketCount,
        'recordDate': recordDate,
      };

  ///Map to object
  factory CustomerModel.fromMap(Map map) => CustomerModel(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      gsmNo: map['gsmNo'],
      corporationId: map['corporationId'],
      roleId: CustomerRoleEnumConverter.getEnumValue(int.parse(map['roleId'].toString())),
      isActive: map['isActive'],
      username: map['username'],
      password: map['password'],
      eMail: map['eMail'],
      secretQuestionId: map['secretQuestionId'],
      secretQuestionAnswer: map['secretQuestionAnswer'],
      notificationCount: map['notificationCount'],
      basketCount: map['basketCount'],
      recordDate: map['recordDate']);
}
