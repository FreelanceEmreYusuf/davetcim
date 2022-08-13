import 'dart:math';

class UserFavProductsModel {
  final int id;
  final int corporationId;
  final int customerId;
  final String image;

  UserFavProductsModel({
    this.id,
    this.corporationId,
    this.customerId,
    this.image,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'corporationId': corporationId,
    'customerId': customerId,
    'image': image,
  };

  ///Map to object
  factory UserFavProductsModel.fromMap(Map map) => UserFavProductsModel(
    id: map['id'],
    corporationId: map['corporationId'],
    customerId: map['customerId'],
    image: map['image'],
  );
}
