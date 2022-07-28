import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final int id;
  final int corporationId;
  final int customerId;
  final int commentId;
  final bool isForAdmin;
  final Timestamp notificationCreateDate;
  final String notificationOwner;
  final String text;

  NotificationModel({
    this.id,
    this.corporationId,
    this.customerId,
    this.commentId,
    this.isForAdmin,
    this.notificationCreateDate,
    this.notificationOwner,
    this.text
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporationId': corporationId,
    'customerId': customerId,
    'commentId': commentId,
    'isForAdmin': isForAdmin,
    'notificationCreateDate': notificationCreateDate,
    'notificationOwner': notificationOwner,
    'text': text
  };

  ///Map to object
  factory NotificationModel.fromMap(Map map) => NotificationModel(
    id: map['id'],
    corporationId: map['corporationId'],
    customerId: map['customerId'],
    commentId: map['commentId'],
    isForAdmin: map['isForAdmin'],
    notificationCreateDate: map['notificationCreateDate'],
    notificationOwner: map['notificationOwner'],
    text: map['text']
  );
}
