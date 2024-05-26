class ParametersModel {
  final int id;
  final int pagingSize;
  final int homeItemSize;
  final int homeSliderItemSize;

  ParametersModel({
    this.id,
    this.pagingSize,
    this.homeItemSize,
    this.homeSliderItemSize,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'pagingSize': pagingSize,
    'homeItemSize': homeItemSize,
    'homeSliderItemSize': homeSliderItemSize,
  };

  ///Map to object
  factory ParametersModel.fromMap(Map map) => ParametersModel(
    id: map['id'],
    pagingSize: map['pagingSize'],
    homeItemSize: map['homeItemSize'],
    homeSliderItemSize: map['homeSliderItemSize'],
  );
}
