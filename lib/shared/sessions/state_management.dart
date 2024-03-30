import 'package:davetcim/shared/sessions/product_filterer_state.dart';
import 'package:davetcim/shared/sessions/reservation_edit_state.dart';
import 'package:davetcim/shared/sessions/user_basket_state.dart';

import 'corporation_registration_state.dart';
import 'organization_type_state.dart';

class StateManagement {
  static void disposeStates() {
    UserBasketState.setAsNull();
    CorporationRegistrationState.setAsNull();
    ReservationEditState.setAsNull();
    ProductFiltererState.setAsNull();
    OrganizationTypeState.setAsNull();
  }


}