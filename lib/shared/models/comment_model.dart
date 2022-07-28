import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final int id;
  final int corporationId;
  final int customerId;
  final int star;
  final bool isApproved;
  final Timestamp date;
  final String comment;
  final String userName;

  CommentModel({
    this.id,
    this.corporationId,
    this.customerId,
    this.star,
    this.isApproved,
    this.date,
    this.comment,
    this.userName,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporationId': corporationId,
    'customerId': customerId,
    'star': star,
    'isApproved': isApproved,
    'date': date,
    'comment': comment,
    'userName': userName,
  };

  ///Map to object
  factory CommentModel.fromMap(Map map) => CommentModel(
    id: map['id'],
    corporationId: map['corporationId'],
    customerId: map['customerId'],
    star: map['star'],
    isApproved: map['isApproved'],
    date: map['date'],
    comment: map['comment'],
    userName: map['userName'],
  );
}
