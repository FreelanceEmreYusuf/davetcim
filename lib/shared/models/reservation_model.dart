import 'dart:math';

class ReservationModel {
  final int id;
  final int corporationId;
  final int customerId;
  final int cost;
  final int date;
  final String description;
  final int endTime;
  final int startTime;
  final bool isMoneyTransfered;

  ReservationModel({
    this.id,
    this.corporationId,
    this.customerId,
    this.cost,
    this.date,
    this.description,
    this.endTime,
    this.startTime,
    this.isMoneyTransfered
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporationId': corporationId,
    'customerId': customerId,
    'cost': cost,
    'date': date,
    'description': description,
    'endTime': endTime,
    'startTime': startTime,
    'isMoneyTransfered': isMoneyTransfered
  };

  ///Map to object
  factory ReservationModel.fromMap(Map map) => ReservationModel(
    id: map['id'],
    corporationId: map['corporationId'],
    customerId: map['customerId'],
    cost:  map['cost'],
    date: map['date'],
    description: map['description'],
    endTime: map['endTime'],
    startTime: map['startTime'],
    isMoneyTransfered: map['isMoneyTransfered']
  );
}
