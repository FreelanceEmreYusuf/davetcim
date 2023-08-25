import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  final int id;
  final int corporationId;
  final String imageUrl;

  ImageModel({
    this.id,
    this.corporationId,
    this.imageUrl,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporationId': corporationId,
    'imageUrl': imageUrl,
  };

  ///Map to object
  factory ImageModel.fromMap(Map map) => ImageModel(
    id: map['id'],
    corporationId: map['corporationId'],
    imageUrl: map['imageUrl'],
  );
}
