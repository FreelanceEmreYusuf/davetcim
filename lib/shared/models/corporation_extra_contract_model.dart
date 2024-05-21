import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class CorporationExtraContractModel {
  int id;
  int corporationId;
  String contractBody;
  Timestamp recordDate;

  CorporationExtraContractModel({
    this.id,
    this.corporationId,
    this.contractBody,
    this.recordDate
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporationId': corporationId,
    'contractBody': contractBody,
    'recordDate': recordDate,
  };

  ///Map to object
  factory CorporationExtraContractModel.fromMap(Map map) => CorporationExtraContractModel(
    id: map['id'],
    corporationId: map['corporationId'],
    contractBody: map['contractBody'],
    recordDate: map['recordDate'],
  );
}
