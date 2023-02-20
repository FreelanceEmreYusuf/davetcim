enum ReservationStatusEnum {
  newRecord,
  approved,
  userRejected,
  adminRejected,
}

class ReservationStatusEnumConverter {
  static ReservationStatusEnum getEnumValue(int value) {
    return ReservationStatusEnum.values[value];
  }

  static int getEnumIndexValue(ReservationStatusEnum value) {
    return value.index;
  }

  static List<int> adminViewedReservationStatus() {
    return [ReservationStatusEnum.newRecord.index];
  }

  static List<int> adminHistoryViewedReservationStatus() {
    return [ReservationStatusEnum.approved.index,
      ReservationStatusEnum.adminRejected.index];
  }
}