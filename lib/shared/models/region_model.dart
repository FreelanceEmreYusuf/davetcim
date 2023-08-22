import 'dart:math';

import 'district_model.dart';

class RegionModel {
  final int id;
  final String name;

  RegionModel({
    this.id,
    this.name
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
  };

  ///Map to object
  factory RegionModel.fromMap(Map map) => RegionModel(
    id: map['id'],
    name: map['name'],
  );
}
