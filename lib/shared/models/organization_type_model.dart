import 'dart:math';

class OrganizationTypeModel {
  final int id;
  final String name;
  final int filteringStatus;
  final int sortingIndex;

  OrganizationTypeModel({
    this.id,
    this.name,
    this.filteringStatus,
    this.sortingIndex,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'filteringStatus': filteringStatus,
    'sortingIndex': sortingIndex,
  };

  ///Map to object
  factory OrganizationTypeModel.fromMap(Map map) => OrganizationTypeModel(
    id: map['id'],
    name: map['name'],
    filteringStatus: map['filteringStatus'],
    sortingIndex: map['sortingIndex'],
  );
}
