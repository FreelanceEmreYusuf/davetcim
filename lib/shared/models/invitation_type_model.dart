import 'dart:math';

class InvitationTypeModel {
  final int id;
  final String name;
  final int filteringStatus;
  final int sortingIndex;

  InvitationTypeModel({
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
  factory InvitationTypeModel.fromMap(Map map) => InvitationTypeModel(
    id: map['id'],
    name: map['name'],
    filteringStatus: map['filteringStatus'],
    sortingIndex: map['sortingIndex'],
  );
}
