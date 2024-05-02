enum ReservationStatusEnum {
  userOffer,
  preReservation,
  userRejectedOffer,
  adminRejectedOffer,
  reservation
}

class ReservationStatusEnumConverter {
  static ReservationStatusEnum getEnumValue(int value) {
    return ReservationStatusEnum.values[value];
  }

  static int getEnumIndexValue(ReservationStatusEnum value) {
    return value.index;
  }

  static List<int> userViewedReservationStatus() {
    return [
      ReservationStatusEnum.userOffer.index,
      ReservationStatusEnum.adminRejectedOffer.index,
      ReservationStatusEnum.preReservation.index,
      ReservationStatusEnum.reservation.index
    ];
  }

  static List<int> adminViewedReservationStatus() {
    return [
      ReservationStatusEnum.userOffer.index,
      ReservationStatusEnum.preReservation.index
    ];
  }

  static List<int> adminHistoryViewedReservationStatus() {
    return [
      ReservationStatusEnum.userOffer.index,
      ReservationStatusEnum.preReservation.index,
      ReservationStatusEnum.adminRejectedOffer.index,
      ReservationStatusEnum.reservation.index
    ];
  }

  static List<int> calenderReservationStatus() {
    return [
      ReservationStatusEnum.preReservation.index,
      ReservationStatusEnum.reservation.index
    ];
  }
}