import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final int id;
  final int recipientCustomerId;
  final int corporationId;
  final int customerId;
  final int commentId;
  final int reservationId;
  final bool isForAdmin;
  final Timestamp notificationCreateDate;
  final String notificationOwner;
  final String text;

  NotificationModel({
    this.id,
    this.recipientCustomerId,
    this.corporationId,
    this.customerId,
    this.commentId,
    this.reservationId,
    this.isForAdmin,
    this.notificationCreateDate,
    this.notificationOwner,
    this.text
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'recipientCustomerId': recipientCustomerId,
    'corporationId': corporationId,
    'customerId': customerId,
    'commentId': commentId,
    'reservationId': reservationId,
    'isForAdmin': isForAdmin,
    'notificationCreateDate': notificationCreateDate,
    'notificationOwner': notificationOwner,
    'text': text
  };

  ///Map to object
  factory NotificationModel.fromMap(Map map) => NotificationModel(
    id: map['id'],
    recipientCustomerId: map['recipientCustomerId'],
    corporationId: map['corporationId'],
    customerId: map['customerId'],
    commentId: map['commentId'],
    reservationId: map['reservationId'],
    isForAdmin: map['isForAdmin'],
    notificationCreateDate: map['notificationCreateDate'],
    notificationOwner: map['notificationOwner'],
    text: map['text']
  );
}
