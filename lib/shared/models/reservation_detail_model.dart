import 'dart:math';

class ReservationDetailModel {
  final int id;
  final int reservationId;
  final int foreignId;
  final String foreignType;

  ReservationDetailModel({
    this.id,
    this.reservationId,
    this.foreignId,
    this.foreignType,
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
