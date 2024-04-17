import 'dart:math';

class ParametersModel {
  final int id;
  final int pagingSize;

  ParametersModel({
    this.id,
    this.pagingSize
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'pagingSize': pagingSize
  };

  ///Map to object
  factory ParametersModel.fromMap(Map map) => ParametersModel(
    id: map['id'],
    pagingSize: map['pagingSize'],
  );
}
