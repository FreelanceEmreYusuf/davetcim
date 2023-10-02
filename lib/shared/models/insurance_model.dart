import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class InsuranceModel {
  final int id;
  final bool insurance;

  InsuranceModel({
    this.id,
    this.insurance,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'insurance': insurance,
  };

  ///Map to object
  factory InsuranceModel.fromMap(Map map) => InsuranceModel(
    id: map['id'],
    insurance: map['insurance'],
  );
}
