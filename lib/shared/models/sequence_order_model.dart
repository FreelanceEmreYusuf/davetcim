import 'dart:math';

class SequenceOrderModel {
  final int id;
  final String name;

  SequenceOrderModel({
    this.id,
    this.name,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
  };

  ///Map to object
  factory SequenceOrderModel.fromMap(Map map) => SequenceOrderModel(
    id: map['id'],
    name: map['name'],
  );
}
