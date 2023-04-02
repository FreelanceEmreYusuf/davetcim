import 'dart:math';

class CompanyModel {
  final int id;
  final String name;
  final int customerId;
  final bool isActive;

  CompanyModel({
    this.id,
    this.name,
    this.customerId,
    this.isActive,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'customerId': customerId,
    'isActive': isActive,
  };

  ///Map to object
  factory CompanyModel.fromMap(Map map) => CompanyModel(
    id: map['id'],
    name: map['name'],
    customerId: map['customerId'],
    isActive: map['isActive'],
  );
}
