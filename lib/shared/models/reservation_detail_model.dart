import 'dart:math';

import 'package:davetcim/shared/models/service_pool_model.dart';

class ReservationDetailModel {
  int id;
  int reservationId;
  int foreignId;
  String foreignType;
  bool hasPrice;
  int price;
  bool priceChangedForCount;
  ServicePoolModel servicePoolModel;

  ReservationDetailModel({
    this.id,
    this.reservationId,
    this.foreignId,
    this.foreignType,
    this.servicePoolModel,
    this.hasPrice,
    this.price,
    this.priceChangedForCount
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'reservationId': reservationId,
    'foreignId': foreignId,
    'foreignType': foreignType,
    'hasPrice': hasPrice,
    'price': price,
    'priceChangedForCount': priceChangedForCount,
  };

  ///Map to object
  factory ReservationDetailModel.fromMap(Map map) => ReservationDetailModel(
    id: map['id'],
    reservationId: map['reservationId'],
    foreignId: map['foreignId'],
    foreignType: map['foreignType'],
    hasPrice: map['hasPrice'],
    price: map['price'],
    priceChangedForCount: map['priceChangedForCount'],
  );
}
