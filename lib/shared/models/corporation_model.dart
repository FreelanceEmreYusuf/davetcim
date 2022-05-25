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
    'corporationId': corporationId,
    'corporationName': corporationName,
    'imageUrl': imageUrl,
  };

  ///Map to object
  factory CorporationModel.fromMap(Map map) => CorporationModel(
    corporationId: map['corporationId'],
    corporationName: map['corporationName'],
    imageUrl: map['imageUrl'],
  );
}
