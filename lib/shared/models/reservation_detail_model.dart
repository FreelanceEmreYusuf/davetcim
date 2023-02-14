import 'dart:math';

import 'package:davetcim/shared/models/service_pool_model.dart';

class ReservationDetailModel {
  final int id;
  final int reservationId;
  final int foreignId;
  final String foreignType;
  ServicePoolModel servicePoolModel;

  ReservationDetailModel({
    this.id,
    this.reservationId,
    this.foreignId,
    this.foreignType,
    this.servicePoolModel,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'reservationId': reservationId,
    'foreignId': foreignId,
    'foreignType': foreignType,
  };

  ///Map to object
  factory ReservationDetailModel.fromMap(Map map) => ReservationDetailModel(
    id: map['id'],
    reservationId: map['reservationId'],
    foreignId: map['foreignId'],
    foreignType: map['foreignType'],
  );
}
