import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationImageModel {
  final int id;
  final String imageUrl;
  final String key;

  ApplicationImageModel({
    this.id,
    this.imageUrl,
    this.key
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'imageUrl': imageUrl,
    'key': key,
  };

  ///Map to object
  factory ApplicationImageModel.fromMap(Map map) => ApplicationImageModel(
    id: map['id'],
    imageUrl: map['imageUrl'],
    key: map['key'],
  );
}
