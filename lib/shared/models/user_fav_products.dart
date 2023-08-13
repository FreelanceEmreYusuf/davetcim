import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserFavProductsModel {
  final int id;
  final int corporationId;
  final int customerId;
  final String image;
  final Timestamp recordDate;

  UserFavProductsModel({
    this.id,
    this.corporationId,
    this.customerId,
    this.image,
    this.recordDate
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporationId': corporationId,
    'customerId': customerId,
    'image': image,
    'recordDate': recordDate,
  };

  ///Map to object
  factory UserFavProductsModel.fromMap(Map map) => UserFavProductsModel(
    id: map['id'],
    corporationId: map['corporationId'],
    customerId: map['customerId'],
    image: map['image'],
    recordDate: map['recordDate'],
  );
}
