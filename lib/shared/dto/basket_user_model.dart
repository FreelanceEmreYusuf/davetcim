import '../models/combo_generic_model.dart';
import '../models/corporate_sessions_model.dart';
import '../models/reservation_model.dart';

class BasketUserModel {
  int sessionId;
  int corporationId;
  int date;
  List<ComboGenericModel> organizationTypeList;
  List<ComboGenericModel> invitationList;
  List<ComboGenericModel> sequenceOrderList;
  List<ReservationModel> reservationList;
  CorporateSessionsModel sessionModel;

  BasketUserModel(
      this.sessionId,
      this.corporationId,
      this.date,
      this.organizationTypeList,
      this.invitationList,
      this.sequenceOrderList,
      this.reservationList,
      this.sessionModel,
  );
}
