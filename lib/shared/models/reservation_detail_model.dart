
class ReservationDetailModel {
  int id;
  int reservationId;
  int foreignId;
  String foreignType;
  String serviceName;
  String serviceBody;
  bool hasPrice;
  int price;
  bool priceChangedForCount;

  ReservationDetailModel({
    this.id,
    this.reservationId,
    this.foreignId,
    this.foreignType,
    this.serviceName,
    this.serviceBody,
    this.hasPrice,
    this.price,
    this.priceChangedForCount
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'reservationId': reservationId,
    'foreignId': foreignId,
    'foreignType': foreignType,
    'serviceName': serviceName,
    'serviceBody': serviceBody,
    'hasPrice': hasPrice,
    'price': price,
    'priceChangedForCount': priceChangedForCount,
  };

  ///Map to object
  factory ReservationDetailModel.fromMap(Map map) => ReservationDetailModel(
    id: map['id'],
    reservationId: map['reservationId'],
    foreignId: map['foreignId'],
    foreignType: map['foreignType'],
    serviceName: map['serviceName'],
    serviceBody: map['serviceBody'],
    hasPrice: map['hasPrice'],
    price: map['price'],
    priceChangedForCount: map['priceChangedForCount'],
  );
}
