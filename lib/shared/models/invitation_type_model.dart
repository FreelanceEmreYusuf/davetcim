import 'dart:math';

class InvitationTypeModel {
  final int id;
  final String name;

  InvitationTypeModel({
    this.id,
    this.name,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
  };

  ///Map to object
  factory InvitationTypeModel.fromMap(Map map) => InvitationTypeModel(
    id: map['id'],
    name: map['name'],
  );
}
