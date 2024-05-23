import 'dart:math';

class ParametersModel {
  final int id;
  final int pagingSize;
  final int vipCorporationAdditionPoint;

  ParametersModel({
    this.id,
    this.pagingSize,
    this.vipCorporationAdditionPoint
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'pagingSize': pagingSize,
    'vipCorporationAdditionPoint': vipCorporationAdditionPoint
  };

  ///Map to object
  factory ParametersModel.fromMap(Map map) => ParametersModel(
    id: map['id'],
    pagingSize: map['pagingSize'],
    vipCorporationAdditionPoint: map['vipCorporationAdditionPoint'],
  );
}
