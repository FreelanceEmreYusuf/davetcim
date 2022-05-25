import 'dart:math';

class CorporationCardModel {
  final String corporationName;
  final String image;

  CorporationCardModel({
    this.corporationName,
    this.image,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'corporationName': corporationName,
    'image': image,
  };

  ///Map to object
  factory CorporationCardModel.fromMap(Map map) => CorporationCardModel(
    corporationName: map['corporationName'],
    image: map['image'],
  );
}
