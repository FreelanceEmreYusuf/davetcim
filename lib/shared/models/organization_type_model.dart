import 'dart:math';

import 'package:davetcim/shared/models/generic_lookup_item_model.dart';

class OrganizationTypeModel {
  final int id;
  final String name;
  final int filteringStatus;
  final int sortingIndex;
  bool  isChecked;

  OrganizationTypeModel({
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
    'sortingIndex': sortingIndex
  };

  ///Map to object
  factory OrganizationTypeModel.fromMap(Map map) => OrganizationTypeModel(
    id: map['id'],
    name: map['name'],
    filteringStatus: map['filteringStatus'],
    sortingIndex: map['sortingIndex']
  );
}
