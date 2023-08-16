import '../models/combo_generic_model.dart';
import '../models/corporate_sessions_model.dart';
import '../models/reservation_model.dart';

class OrderBasketDto {
  int count;
  String invitationType;
  String sequenceOrder;
  

  OrderBasketDto(
      this.count,
      this.invitationType,
      this.sequenceOrder,
  );
}
