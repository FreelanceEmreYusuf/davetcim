import 'dart:math';

class CorporationModel {
  final int corporationId;
  final String corporationName;
  final String imageUrl;
  final String description;
  final String address;
  final double averageRating;
  final int companyId;
  final String district;
  final bool isActive;
  final bool isPopularCorporation;
  final int maxPopulation;
  final int organizationEnd;
  final int organizationStart;
  final int ratingCount;
  final String region;
  final String telephoneNo;
  final List<String> invitationUniqueIdentifier;
  final List<String> organizationUniqueIdentifier;
  final List<String> sequenceOrderUniqueIdentifier;

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
    this.organizationEnd,
    this.organizationStart,
    this.ratingCount,
    this.region,
    this.telephoneNo,
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
    'organizationEnd': organizationEnd,
    'organizationStart': organizationStart,
    'ratingCount': ratingCount,
    'region': region,
    'telephoneNo': telephoneNo,
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
    organizationEnd: map['organizationEnd'],
    organizationStart: map['organizationStart'],
    ratingCount: map['ratingCount'],
    region: map['region'],
    telephoneNo: map['telephoneNo'],
    invitationUniqueIdentifier: List.from(map['invitationUniqueIdentifier']) ,
    organizationUniqueIdentifier: List.from(map['organizationUniqueIdentifier']),
    sequenceOrderUniqueIdentifier: List.from(map['sequenceOrderUniqueIdentifier']),
  );
}
