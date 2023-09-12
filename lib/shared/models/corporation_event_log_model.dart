import 'package:cloud_firestore/cloud_firestore.dart';

class CorporationEventLogModel {
  int id;
  int corporationId;
  int date;
  int commentCount;
  int commentCountMonth;
  int commentCountYear;
  int favoriteCount;
  int favoriteCountMonth;
  int favoriteCountYear;
  int reservationCount;
  int reservationCountMonth;
  int reservationCountYear;
  int reservationTotalAmount;
  int reservationTotalAmountMonth;
  int reservationTotalAmountYear;
  int visitCount;
  int visitCountMonth;
  int visitCountYear;
  Timestamp recordDate;

  CorporationEventLogModel({
    this.id,
    this.corporationId,
    this.date,
    this.commentCount,
    this.commentCountMonth,
    this.commentCountYear,
    this.favoriteCount,
    this.favoriteCountMonth,
    this.favoriteCountYear,
    this.reservationCount,
    this.reservationCountMonth,
    this.reservationCountYear,
    this.reservationTotalAmount,
    this.reservationTotalAmountMonth,
    this.reservationTotalAmountYear,
    this.visitCount,
    this.visitCountMonth,
    this.visitCountYear,
    this.recordDate,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporationId': corporationId,
    'date': date,
    'commentCount': commentCount,
    'favoriteCount': favoriteCount,
    'reservationCount': reservationCount,
    'reservationTotalAmount': reservationTotalAmount,
    'visitCount': visitCount,
    'recordDate': recordDate,
  };

  ///Map to object
  factory CorporationEventLogModel.fromMap(Map map) => CorporationEventLogModel(
    id: map['id'],
    corporationId: map['corporationId'],
    date: map['date'],
    commentCount: map['commentCount'],
    favoriteCount: map['favoriteCount'],
    reservationCount: map['reservationCount'],
    reservationTotalAmount: map['reservationTotalAmount'],
    visitCount: map['visitCount'],
    recordDate: map['recordDate'],
  );
}
