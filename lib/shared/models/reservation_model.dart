import 'dart:math';

class ReservationModel {
  final int id;
  final int corporationId;
  final int customerId;
  final int cost;
  final int date;
  final String description;
  final int sessionId;
  final bool isMoneyTransfered;
  final bool isActive;

  ReservationModel({
    this.id,
    this.corporationId,
    this.customerId,
    this.cost,
    this.date,
    this.description,
    this.sessionId,
    this.isMoneyTransfered,
    this.isActive,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporationId': corporationId,
    'customerId': customerId,
    'cost': cost,
    'date': date,
    'description': description,
    'sessionId': sessionId,
    'isMoneyTransfered': isMoneyTransfered,
    'isActive': isActive
  };

  ///Map to object
  factory ReservationModel.fromMap(Map map) => ReservationModel(
    id: map['id'],
    corporationId: map['corporationId'],
    customerId: map['customerId'],
    cost:  map['cost'],
    date: map['date'],
    description: map['description'],
    sessionId: map['sessionId'],
    isMoneyTransfered: map['isMoneyTransfered'],
    isActive: map['isActive']
  );
}
