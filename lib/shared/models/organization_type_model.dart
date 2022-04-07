import 'dart:math';

class OrganizationTypeModel {
  final int id;
  final String name;

  OrganizationTypeModel({
    this.id,
    this.name,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
  };

  ///Map to object
  factory OrganizationTypeModel.fromMap(Map map) => OrganizationTypeModel(
    id: map['id'],
    name: map['name'],
  );
}
