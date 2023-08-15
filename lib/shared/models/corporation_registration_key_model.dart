import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class CorporationRegistrationKeyModel {
  final int id;
  final int companyId;
  final int keyNumber;
  final bool isActive;
  final Timestamp recordDate;


  CorporationRegistrationKeyModel({
    this.id,
    this.companyId,
    this.keyNumber,
    this.isActive,
    this.recordDate,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'companyId': companyId,
    'keyNumber': keyNumber,
    'isActive': isActive,
    'recordDate': recordDate,
  };

  ///Map to object
  factory CorporationRegistrationKeyModel.fromMap(Map map) => CorporationRegistrationKeyModel(
    id: map['id'],
    companyId: map['companyId'],
    keyNumber: map['keyNumber'],
    isActive: map['isActive'],
    recordDate: map['recordDate'],
  );
}
