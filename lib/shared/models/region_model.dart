import 'dart:math';

import 'district_model.dart';

class RegionModel {
  int id;
  String name;
  bool isActive;

  RegionModel({
    this.id,
    this.name,
    this.isActive
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'isActive': isActive,
  };

  ///Map to object
  factory RegionModel.fromMap(Map map) => RegionModel(
    id: map['id'],
    name: map['name'],
    isActive: map['isActive'],
  );
}
