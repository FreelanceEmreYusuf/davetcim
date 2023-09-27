class GenericLookupItemModel {
  int id;
  String name;
  int filteringStatus;
  int sortingIndex;

  GenericLookupItemModel({
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
    'sortingIndex': sortingIndex
  };

  ///Map to object
  factory GenericLookupItemModel.fromMap(Map map) => GenericLookupItemModel(
    id: map['id'],
    name: map['name'],
    filteringStatus: map['filteringStatus'],
    sortingIndex: map['sortingIndex'],
  );
}