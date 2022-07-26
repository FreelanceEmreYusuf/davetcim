import 'dart:math';

class CorporationModel {
  final int corporationId;
  final String corporationName;
  final String imageUrl;
  final String description;

  CorporationModel({
    this.corporationId,
    this.corporationName,
    this.imageUrl,
    this.description,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': corporationId,
    'corporationName': corporationName,
    'imageUrl': imageUrl,
    'description': description,
  };

  ///Map to object
  factory CorporationModel.fromMap(Map map) => CorporationModel(
    corporationId: map['id'],
    corporationName: map['corporationName'],
    imageUrl: map['imageUrl'],
    description: map['description'],
  );
}
