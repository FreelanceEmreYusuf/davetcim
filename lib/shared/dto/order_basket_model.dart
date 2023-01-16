import '../models/combo_generic_model.dart';
import '../models/corporate_sessions_model.dart';
import '../models/reservation_model.dart';

class OrderBasketModel {
  int count;
  String invitationType;
  String sequenceOrder;
  

  OrderBasketModel(
      this.count,
      this.invitationType,
      this.sequenceOrder,
  );
}
