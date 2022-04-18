import 'dart:math';

class BypassInfoPageModel {
  final int id;
  final String imeiCode;

  BypassInfoPageModel({
    this.id,
    this.imeiCode
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'imeiCode': imeiCode
  };

  ///Map to object
  factory BypassInfoPageModel.fromMap(Map map) => BypassInfoPageModel(
    id: map['id'],
    imeiCode: map['imeiCode']
  );
}
