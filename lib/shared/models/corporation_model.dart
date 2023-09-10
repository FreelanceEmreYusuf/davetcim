import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class CorporationModel {
  int corporationId;
  String corporationName;
  String imageUrl;
  String description;
  String address;
  double averageRating;
  int companyId;
  String district;
  bool isActive;
  bool isPopularCorporation;
  int maxPopulation;
  int ratingCount;
  int minReservationAmount;
  String region;
  String telephoneNo;
  String email;
  Timestamp recordDate;
  List<String> invitationUniqueIdentifier;
  List<String> organizationUniqueIdentifier;
  List<String> sequenceOrderUniqueIdentifier;

  CorporationModel({
    this.corporationId,
    this.corporationName,
    this.imageUrl,
    this.description,
    this.address,
    this.averageRating,
    this.companyId,
    this.district,
    this.isActive,
    this.isPopularCorporation,
    this.maxPopulation,
    this.ratingCount,
    this.minReservationAmount,
    this.region,
    this.telephoneNo,
    this.email,
    this.recordDate,
    this.invitationUniqueIdentifier,
    this.organizationUniqueIdentifier,
    this.sequenceOrderUniqueIdentifier,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': corporationId,
    'corporationName': corporationName,
    'imageUrl': imageUrl,
    'description': description,
    'address': address,
    'averageRating': averageRating,
    'companyId': companyId,
    'district': district,
    'isActive': isActive,
    'isPopularCorporation': isPopularCorporation,
    'maxPopulation': maxPopulation,
    'ratingCount': ratingCount,
    'minReservationAmount': minReservationAmount,
    'region': region,
    'telephoneNo': telephoneNo,
    'email': email,
    'recordDate': recordDate,
    'invitationUniqueIdentifier': invitationUniqueIdentifier,
    'organizationUniqueIdentifier': organizationUniqueIdentifier,
    'sequenceOrderUniqueIdentifier': sequenceOrderUniqueIdentifier,
  };

  ///Map to object
  factory CorporationModel.fromMap(Map map) => CorporationModel(
    corporationId: map['id'],
    corporationName: map['corporationName'],
    imageUrl: map['imageUrl'],
    description: map['description'],
    address: map['address'],
    averageRating: double.parse(map['averageRating'].toString()),
    companyId: map['companyId'],
    district: map['district'],
    isActive: map['isActive'],
    isPopularCorporation: map['isPopularCorporation'],
    maxPopulation: map['maxPopulation'],
    ratingCount: map['ratingCount'],
    minReservationAmount: map['minReservationAmount'],
    region: map['region'],
    telephoneNo: map['telephoneNo'],
    email: map['email'],
    recordDate: map['recordDate'],
    invitationUniqueIdentifier: List.from(map['invitationUniqueIdentifier']) ,
    organizationUniqueIdentifier: List.from(map['organizationUniqueIdentifier']),
    sequenceOrderUniqueIdentifier: List.from(map['sequenceOrderUniqueIdentifier']),
  );
}
