class GenericLookupItemModel {
  int id;
  String name;
  int filteringStatus;

  GenericLookupItemModel({
    this.id,
    this.name,
    this.filteringStatus,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'filteringStatus': filteringStatus,
  };

  ///Map to object
  factory GenericLookupItemModel.fromMap(Map map) => GenericLookupItemModel(
    id: map['id'],
    name: map['name'],
    filteringStatus: map['filteringStatus'],
  );
}