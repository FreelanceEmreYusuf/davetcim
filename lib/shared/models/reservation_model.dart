import 'dart:math';

import 'package:davetcim/shared/models/reservation_detail_model.dart';

class ReservationModel {
  final int id;
  final int corporationId;
  final int customerId;
  final int cost;
  final int date;
  final String description;
  final int sessionId;
  final int reservationStatus;
  final bool isActive;
  final int invitationCount;
  final String invitationType;
  final String seatingArrangement;
  final ReservationDetailModel detailModel;

  ReservationModel({
    this.id,
    this.corporationId,
    this.customerId,
    this.cost,
    this.date,
    this.description,
    this.sessionId,
    this.reservationStatus,
    this.isActive,
    this.invitationCount,
    this.invitationType,
    this.seatingArrangement,
    this.detailModel,
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
    'reservationStatus': reservationStatus,
    'isActive': isActive,
    'invitationCount': invitationCount,
    'invitationType': invitationType,
    'seatingArrangement': seatingArrangement,
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
    reservationStatus: map['reservationStatus'],
    isActive: map['isActive'],
    invitationCount: map['invitationCount'],
    invitationType: map['invitationType'],
    seatingArrangement: map['seatingArrangement'],
  );
}
