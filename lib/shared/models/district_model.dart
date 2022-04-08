import 'dart:math';

class DistrictModel {
  final int id;
  final String name;
  final int regionId;
  final int filteringStatus;
  final int sortingIndex;

  DistrictModel({
    this.id,
    this.name,
    this.regionId,
    this.filteringStatus,
    this.sortingIndex,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'regionId': regionId,
    'filteringStatus': filteringStatus,
    'sortingIndex': sortingIndex,
  };

  ///Map to object
  factory DistrictModel.fromMap(Map map) => DistrictModel(
    id: map['id'],
    name: map['name'],
    regionId: map['regionId'],
    filteringStatus: map['filteringStatus'],
    sortingIndex: map['sortingIndex'],
  );
}
