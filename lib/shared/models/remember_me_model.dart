import 'dart:math';

class RememberMeModel {
  int id;
  String imeiCode;
  String userName;
  String password;

  RememberMeModel({
    this.id,
    this.imeiCode,
    this.userName,
    this.password
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'imeiCode': imeiCode,
    'userName': userName,
    'password': password,
  };

  ///Map to object
  factory RememberMeModel.fromMap(Map map) => RememberMeModel(
    id: map['id'],
    imeiCode: map['imeiCode'],
    userName: map['userName'],
    password: map['password'],
  );
}
