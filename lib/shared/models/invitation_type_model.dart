import 'dart:math';

import 'generic_lookup_item_model.dart';

class InvitationTypeModel {
  final int id;
  final String name;
  final int filteringStatus;
  bool  isChecked;

  InvitationTypeModel({
    this.id,
    this.name,
    this.filteringStatus,
    this.isChecked
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'filteringStatus': filteringStatus,
  };

  ///Map to object
  factory InvitationTypeModel.fromMap(Map map) => InvitationTypeModel(
    id: map['id'],
    name: map['name'],
    filteringStatus: map['filteringStatus'],
  );
}
