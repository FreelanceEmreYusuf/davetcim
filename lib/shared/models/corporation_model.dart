import 'dart:math';

class CorporationModel {
  final int corporationId;
  final String corporationName;
  final String imageUrl;

  CorporationModel({
    this.corporationId,
    this.corporationName,
    this.imageUrl,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': corporationId,
    'corporationName': corporationName,
    'imageUrl': imageUrl,
  };

  ///Map to object
  factory CorporationModel.fromMap(Map map) => CorporationModel(
    corporationId: map['id'],
    corporationName: map['corporationName'],
    imageUrl: map['imageUrl'],
  );
}
