import 'dart:math';

import 'generic_lookup_item_model.dart';

class SequenceOrderModel {
  final int id;
  final String name;
  final int filteringStatus;
  final int sortingIndex;
  bool  isChecked;

  SequenceOrderModel({
    this.id,
    this.name,
    this.filteringStatus,
    this.sortingIndex,
    this.isChecked
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
