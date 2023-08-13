import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  final int id;
  final String name;
  final int customerId;
  final bool isActive;
  final Timestamp recordDate;

  CompanyModel({
    this.id,
    this.name,
    this.customerId,
    this.isActive,
    this.recordDate
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'customerId': customerId,
    'isActive': isActive,
    'recordDate': recordDate,
  };

  ///Map to object
  factory CompanyModel.fromMap(Map map) => CompanyModel(
    id: map['id'],
    name: map['name'],
    customerId: map['customerId'],
    isActive: map['isActive'],
    recordDate: map['recordDate'],
  );
}
