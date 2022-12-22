import 'dart:math';

class ServiceCorporatePoolModel {
  final int id;
  final int corporateId;
  final int serviceId;
  final int price;
  final bool priceChangedForCount;
  final bool hasPrice;

  ServiceCorporatePoolModel({
    this.id,
    this.corporateId,
    this.serviceId,
    this.price,
    this.priceChangedForCount,
    this.hasPrice,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporateId': corporateId,
    'serviceId': serviceId,
    'price': price,
    'priceChangedForCount': priceChangedForCount,
    'hasPrice': hasPrice,
  };

  ///Map to object
  factory ServiceCorporatePoolModel.fromMap(Map map) => ServiceCorporatePoolModel(
    id: map['id'],
    corporateId: map['corporateId'],
    serviceId: map['serviceId'],
    price: map['price'],
    priceChangedForCount: map['priceChangedForCount'],
    hasPrice: map['hasPrice'],
  );
}
