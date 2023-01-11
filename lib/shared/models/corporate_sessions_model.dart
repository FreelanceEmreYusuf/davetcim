import 'dart:math';

class CorporateSessionsModel {
  final int id;
  final int corporationId;
  final String name;
  final int midweekPrice;
  final int weekendPrice;
  bool hasReservation;

  CorporateSessionsModel({
    this.id,
    this.corporationId,
    this.name,
    this.midweekPrice,
    this.weekendPrice,
    this.hasReservation,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporationId': corporationId,
    'name': name,
    'midweekPrice': midweekPrice,
    'weekendPrice': weekendPrice,
  };

  ///Map to object
  factory CorporateSessionsModel.fromMap(Map map) => CorporateSessionsModel(
    id: map['id'],
    corporationId: map['corporationId'],
    name: map['name'],
    midweekPrice: map['midweekPrice'],
    weekendPrice: map['weekendPrice'],
  );
}