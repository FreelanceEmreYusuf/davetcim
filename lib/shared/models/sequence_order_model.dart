import 'dart:math';

class SequenceOrderModel {
  final int id;
  final String name;
  final int filteringStatus;
  final int sortingIndex;

  SequenceOrderModel({
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
  factory SequenceOrderModel.fromMap(Map map) => SequenceOrderModel(
    id: map['id'],
    name: map['name'],
    filteringStatus: map['filteringStatus'],
    sortingIndex: map['sortingIndex'],
  );
}
