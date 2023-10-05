import 'package:cloud_firestore/cloud_firestore.dart';

class CorporationPackageServicesModel {
  int id;
  int corporateId;
  String title;
  String body;
  int price;
  bool isActive;
  int createIntDate;
  Timestamp createDate;

  CorporationPackageServicesModel({
    this.id,
    this.corporateId,
    this.title,
    this.body,
    this.isActive,
    this.price,
    this.createIntDate,
    this.createDate,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporateId': corporateId,
    'title': title,
    'body': body,
    'isActive': isActive,
    'price': price,
    'createIntDate': createIntDate,
    'createDate': createDate,
  };

  ///Map to object
  factory CorporationPackageServicesModel.fromMap(Map map) => CorporationPackageServicesModel(
    id: map['id'],
    corporateId: map['corporateId'],
    title: map['title'],
    body: map['body'],
    isActive: map['isActive'],
    price: map['price'],
    createIntDate: map['createIntDate'],
    createDate: map['createDate'],
  );
}
