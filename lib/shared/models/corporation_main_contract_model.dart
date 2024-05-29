class CorporationMainContractModel {
  int id;
  String contractRow;
  bool isSell;

  CorporationMainContractModel({
    this.id,
    this.contractRow,
    this.isSell
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'contractRow': contractRow,
    'isSell': isSell
  };

  ///Map to object
  factory CorporationMainContractModel.fromMap(Map map) => CorporationMainContractModel(
    id: map['id'],
    contractRow: map['contractRow'],
    isSell: map['isSell']
  );
}
