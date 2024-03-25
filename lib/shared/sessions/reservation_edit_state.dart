import 'package:davetcim/shared/dto/reservation_detail_view_dto.dart';

class ReservationEditState {
  static ReservationDetailViewDto reservationDetail;

  static bool isPresent() {
    return reservationDetail != null;
  }

  static void set() {

  }

  static void setAsNull() {
    reservationDetail = null;
  }
}